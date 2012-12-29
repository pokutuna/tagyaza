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

  def self.open_pack(set_code)
    cards = []
    Card.transaction {
      cards.push(get_rare_randomely(set_code))

      3.times do
        cards.push(get_uncommon(set_code))
      end

      11.times do
        cards.push(get_common(set_code))
      end
    }
    cards
  end

  def self.get_rare_randomely(set_code)
    card = nil
    card = get_sr(set_code) if rand(0..7) == 0
    card = get_r(set_code) if card.nil?
    card
  end

  def self.get_sr(set_code)
    Card.where(:set_code => set_code, :rarelity => '神話レア').order('RANDOM()').first
  end

  def self.get_r(set_code)
    Card.where(:set_code => set_code, :rarelity => 'レア').order('RANDOM()').first
  end

  def self.get_uncommon(set_code)
    Card.where(:set_code => set_code, :rarelity => 'アンコモン').order('RANDOM()').first
  end

  def self.get_common(set_code)
    Card.where(:set_code => set_code, :rarelity => 'コモン').order('RANDOM()').first
  end

end
