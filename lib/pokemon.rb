require 'pry'

class Pokemon

	attr_reader :id, :name, :type, :hp

	def initialize(id, name, type, hp, db)
		@id = id
		@name = name
		@type = type
		@hp = hp
		@db = db
	end

	def self.save(pokemon_name, pokemon_type, db)
		db.execute("INSERT INTO pokemon_table (name, type) VALUES (?, ?)", pokemon_name, pokemon_type)
	end

	def self.find(row_id, db)
		pokemon_array = db.execute('SELECT * FROM pokemon_table WHERE id = ?', row_id)
		id = pokemon_array[0][0]
		name = pokemon_array[0][1]
		type = name = pokemon_array[0][2]
		hp = pokemon_array[0][3]
		Pokemon.new(id, name, type, hp, db)
	end

	def alter_hp(new_hp)
		@db.execute('UPDATE pokemon_table SET hp = ? WHERE id = ?', new_hp, self.id)
	end

end