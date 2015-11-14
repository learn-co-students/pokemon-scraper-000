require 'nokogiri'

class Scraper

	def initialize(db)
		@db = db
	end

	def scrape
		html = File.read('./pokemon_index.html')
		pokemons = Nokogiri::HTML(html)
		pokemons.css('span.infocard-tall').each do |pokemon|
			pokemon_name = pokemon.css('a.ent-name').text
			pokemon_type = pokemon.css('small.aside').text
			Pokemon.save(pokemon_name, pokemon_type, @db)
		end
	end

end