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
  @db  = SQLite3::Database.new ":memory:"
  @db.execute("CREATE TABLE pokemon (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, type TEXT)")
  preparedDB = db.prepare("INSERT INTO pokemon (name, type) VALUES (?, ?)")
  html = File.read("pokemon_index.html")
  pokemon_scrap = Nokogiri::HTML(html)
    pokemon_scrap.css("span.infocard-tall").each do |pokemon|
      pkName = pokemon.css("a.ent-name").text
      pkType = pokemon.css("a.itype").text
      @newPokemonInstance.save(pkName, pkType, preparedDB)
    end
     preparedDB.close
  end

end

#trying to code this out so that I can make another pull request.






