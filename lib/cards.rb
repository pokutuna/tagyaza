# -*- coding: utf-8 -*-
require 'active_record'

DB_FILE = File.join(File.dirname(__FILE__), '..', 'db', 'cards.sqlite3')

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => DB_FILE
  )

class Card < ActiveRecord::Base

  def self.parse(set_code, card_text)

    set_no   = card_text.slice(/\A(\d+)\./, 1).strip.to_i
    name_eng = card_text.slice(/英語名：(.+)\n/, 1).strip
    name_jpn = card_text.slice(/日本語名：(.+)\n/, 1).strip
    rarelity = card_text.slice(/稀少度：(.+)/, 1).strip

    Card.new(
      :set_code => set_code,
      :set_no   => set_no,
      :name_eng => name_eng,
      :name_jpn => name_jpn,
      :rarelity => rarelity
      )
  end
end
