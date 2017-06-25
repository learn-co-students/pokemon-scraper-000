class Pokemon

	DEFAULT_HP = 60

	attr_accessor :id, :name, :type, :db, :hp

	def initialize(data = [])
		@db = data
	end


	def self.save(name, type, db)
		command = 
			<<-SQL
				INSERT INTO pokemon (name, type) VALUES (?,?);
			SQL
		db.execute(command, name, type)
	end

	def self.find(id, db)
		command = <<-SQL
      	SELECT * FROM pokemon WHERE id = ?;
    	SQL

    	db

    	pokedata = db.execute(command, id)
    	id = pokedata[0][0]
    	name = pokedata[0][1]
    	type = pokedata[0][2]
    	hp = pokedata[0][3]

    	Pokemon.new.tap do |pokemon|
     		pokemon.id = id
      	pokemon.name = name
      	pokemon.type = type
      	pokemon.db = db
      	pokemon.hp = hp
		end

	end

end
