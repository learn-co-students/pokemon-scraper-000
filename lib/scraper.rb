require 'pry'
require 'nokogiri'

class Scraper

  def initialize(database)
    @db = database
  end

  def scrape

    html = File.read('./pokemon_index.html')
    doc = Nokogiri::HTML(html)
    doc.css("span.infocard-tall").each_with_index do |pokemon, index|
      pokemon_name = pokemon.css("a.ent-name").text
      pokemon_type = pokemon.css('small.aside').text
      id = index
      Pokemon.save(pokemon_name, pokemon_type, @db)
    end
  end

end