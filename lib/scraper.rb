require "nokogiri"
require "pry"

class Scraper

  attr_reader :db, :newPokemonInstance

  POKEMON = []

  def initialize(db)
    @db = db
    @newPokemonInstance = Pokemon.new
  end

  def scrape
  # preparedDB = db.prepare("INSERT INTO pokemon (name, type) VALUES (?, ?)")
  html = File.read("pokemon_index.html")
  pokemon_scrap = Nokogiri::HTML(html)
    pokemon_scrap.css("span.infocard-tall").each do |pokemon|
      pkName = pokemon.css("a.ent-name").text.to_s
      pkType = pokemon.css("a.itype").text.to_s
      newPokemonInstance.save(pkName, pkType, db)
    end
  end

end

#trying to code this out so that I can make another pull request.






