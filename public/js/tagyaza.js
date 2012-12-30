// Generated by CoffeeScript 1.4.0
var Card, Tagyaza;

Tagyaza = {
  init: function() {
    console.log('tagyaza');
    this.cardDiv = $('#cards');
    return $('#buttons').on('click', 'button', this.clickButton);
  },
  cardDiv: void 0,
  clickButton: function() {
    var input;
    input = $(".set-group." + this.name).find('input');
    console.log(input.attr('value'));
    input.attr('value', parseInt(input.attr('value'), 10) + 1);
    return $.getJSON('/cards.json', {
      set: this.name
    }).success(function(data) {
      var c, card, cards, _i, _len, _results;
      cards = (function() {
        var _i, _len, _ref, _results;
        _ref = data.reverse();
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          card = _ref[_i];
          _results.push(new Card(card));
        }
        return _results;
      })();
      _results = [];
      for (_i = 0, _len = cards.length; _i < _len; _i++) {
        c = cards[_i];
        _results.push(Tagyaza.appendCard(c));
      }
      return _results;
    });
  },
  appendCard: function(card) {
    var _this = this;
    return setTimeout(function() {
      return card.toHtml().prependTo(_this.cardDiv);
    }, 0);
  }
};

Card = (function() {

  function Card(json) {
    this.set_code = json.card.set_code;
    this.set_no = json.card.set_no;
    this.name_eng = json.card.name_eng;
    this.name_jpn = json.card.name_jpn;
    this.rarelity = Card.rarelity_str_map(json.card.rarelity);
  }

  Card.prototype.toHtml = function() {
    return $('<tr/>').addClass('card').append($('<td/>').text(this.set_code).addClass('code').addClass(this.set_code)).append($('<td/>').text(("000" + this.set_no).slice(-3)).addClass('no')).append($('<td/>').addClass('name').append($('<a/>').text(this.name_jpn).attr('href', this.cardUrl()))).append($('<td/>').text(this.rarelity).addClass('rarelity').addClass(this.rarelity));
  };

  Card.prototype.cardUrl = function() {
    return 'http://whisper.wisdom-guild.net/card/' + this.name_eng.replace(/\s/g, '+');
  };

  Card.rarelity_str_map = function(jpn_text) {
    switch (jpn_text) {
      case '神話レア':
        return 'MR';
      case 'レア':
        return 'R';
      case 'アンコモン':
        return 'UC';
      case 'コモン':
        return 'C';
      default:
        throw new Error("there's no mapping " + jpn_text);
    }
  };

  return Card;

})();

jQuery(function() {
  return Tagyaza.init();
});
