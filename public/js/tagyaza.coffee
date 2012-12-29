  Tagyaza =
    init: ->
      @cardDiv = $('#cards')
      $('#buttons').on 'click', 'button', @clickButton

    cardDiv: undefined

    clickButton: ->
      $.getJSON('/cards.json', set: @name).success (data)->
        cards = (new Card(card) for card in data.reverse())
        Tagyaza.appendCard(c) for c in cards

    appendCard: (card) ->
      setTimeout =>
        card.toHtml().prependTo(@cardDiv)
      , 0


  class Card
    constructor: (json) ->
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
        when '神話レア' then 'SR'
        when 'レア' then 'R'
        when 'アンコモン' then 'UC'
        when 'コモン' then 'C'
        else throw new Error("there's no mapping #{jpn_text}")

  jQuery ->
    Tagyaza.init()
