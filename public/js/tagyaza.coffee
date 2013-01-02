  Tagyaza =
    init: ->
      @cardDiv = $('#cards')
      $('#buttons').on 'click', 'button', @clickButton
      $('#open-all').on 'click', @openAll
      $('#reset').on 'click', @reset
      $('#output').on 'click', @output

    cards: []

    cardDiv: undefined

    clickButton: ->
      dfd = $.Deferred()
      input = $(".set-group.#{@name}").find('input')
      input.attr('value', parseInt(input.attr('value'), 10) + 1)
      $.getJSON('/cards.json', set: @name).success (data) =>
        for card_data in data.reverse()
          card = new Card(card_data)
          Tagyaza.cards.push(card)
          card.toHtml().prependTo(Tagyaza.cardDiv)

        dfd.resolve()
      return dfd.promise()

    openAll: ->
      buttons = $('button')
      buttons.attr('disabled', true)
      $('#loading').show()
      requests = (Tagyaza.clickButton.apply(btn) for btn in $('#buttons button'))
      $.when.apply($, requests).always ->
        buttons.removeAttr('disabled')
        $('#loading').hide()

    reset: ->
      if confirm('リセットしてよろしいですか？')
        Tagyaza.cards = []
        Tagyaza.cardDiv.empty()
        $(ta).attr('value', 0) for ta in $('.set-group input')
        $('#cardlist-link').hide()

    output: ->
      ids = (card.id for card in Tagyaza.cards)
      return if ids.length == 0
      joined = ids.join(',')
      cardlistUrl = [location.origin, '/cardlist?ids=', joined].join('')
      $('#cardlist-link').slideDown()
      $('#output-hidden').val(joined)
      $('#cardlist-url').val(cardlistUrl)
      $('#open-cardlist').attr('href', cardlistUrl)
      $('#output-submit').click()


  class Card
    constructor: (json) ->
      @id       = json.card.id
      @set_code = json.card.set_code
      @set_no   = json.card.set_no
      @name_eng = json.card.name_eng
      @name_jpn = json.card.name_jpn
      @rarelity = Card.rarelity_str_map(json.card.rarelity)

    toHtml: ->
      $('<tr/>').addClass('card')
        .append($('<td/>').text(@set_code).addClass('code').addClass(@set_code))
        .append($('<td/>').text(("000" + @set_no).slice(-3)).addClass('no'))
        .append($('<td/>').addClass('name').append($('<a/>').text(@name_jpn).attr('href', @cardUrl())))
        .append($('<td/>').text(@rarelity).addClass('rarelity').addClass(@rarelity))

    cardUrl: ->
      'http://whisper.wisdom-guild.net/card/' + @name_eng.replace(/\s/g, '+')

    @rarelity_str_map: (jpn_text) ->
      switch jpn_text
        when '神話レア' then 'MR'
        when 'レア' then 'R'
        when 'アンコモン' then 'UC'
        when 'コモン' then 'C'
        else throw new Error("there's no mapping #{jpn_text}")

  jQuery ->
    Tagyaza.init()
