class Scraper

  def initialize(database)
    @database = database
  end

  def scrape
    Pokemon.reset
    poke_index = Nokogiri::HTML(open("#{__dir__}/../pokemon_index.html")) 
    poke_index.css(".infocard-tall").each{|infocard|
      pokemon_name = infocard.css(".ent-name").text
      this_pokemon = Pokemon.new(pokemon_name)
      pokemon_types = infocard.css("a.itype").text.scan(/[A-Z][a-z]+/)
      pokemon_types.each{|pokemons_type| this_pokemon.type = pokemons_type}
    }
    Pokemon.save_to_database(@database)
  end
end