class Scraper
  def initialize(db)
    @db = db
  end

  def scrape
    statement = @db.prepare("INSERT INTO pokemons (name, type) VALUES (?, ?)")
	doc = Nokogiri::HTML(File.open("pokemon_index.html"))	
	doc.css("span.infocard-tall").each do |span|
	  name = span.css("a.ent-name").text
	  type = span.css("small.aside").text
	  statement.execute(name, type)
	end
  end  
end
