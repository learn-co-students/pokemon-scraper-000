require 'pry'

class Pokemon

  attr_accessor :id, :name, :type, :hp, :db 

  def initialize(id, name, type, hp, db)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db =  db
    #binding.pry
  end

  def self.save(pokemon_name, pokemon_type, db)
    
    #?, ? as place holders. Can't use string interoplation
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", pokemon_name, pokemon_type)
   
  end

  def self.find(id, db)
    selected_pokemon = db.execute('SELECT * FROM pokemon WHERE id = ?', id)
    id = selected_pokemon[0][0]
    name = selected_pokemon[0][1]
    type = selected_pokemon[0][2]
    hp = selected_pokemon[0][3]
    Pokemon.new(id, name, type, hp, db)
  end



  def alter_hp(hp)
    @db.execute('UPDATE pokemon SET hp = ? WHERE id = ?', hp, self.id)
  end

end