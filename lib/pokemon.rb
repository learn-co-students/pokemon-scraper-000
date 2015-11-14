class Pokemon
  def self.save(name, type, db)
    db.execute("INSERT INTO pokemons (name, type) VALUES (?, ?)", name, type)
  end
  
  def self.find(id, db)
    name, type, hp = db.execute("SELECT name, type, hp FROM pokemons WHERE id = ?", @id).flatten
	Pokemon.new(id, name, type, hp, db)
  end
  
  attr_reader :name, :type, :hp
  def initialize(id, name, type, hp, db)
	@db = db
    @id = id
    @name = name
	@type = type
	@hp = hp
  end

  def alter_hp(new_hp)
    @hp = new_hp
	@db.execute("UPDATE pokemons SET hp = ? WHERE id = ?", new_hp, @id)
  end	
end