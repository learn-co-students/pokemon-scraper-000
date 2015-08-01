require 'nokogiri'

class Scraper

	def initialize(db)
		@db = db
	end

	def scrape
		html = File.read('./pokemon_index.html')
		pokemons = Nokogiri::HTML(html)
		pokemon_array = []
		pokemons.css('span.infocard-tall a.ent-name').each do |pokemon|
			pokemon_array<<pokemon.text
		end
	end

end