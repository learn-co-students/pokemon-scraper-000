class Pokemon

  @@pokemon = []
  @@pending_pokemon = []

  attr_accessor :hp, :database
  attr_reader :name, :type

  def initialize(name)
    @name = name
    @type = []
    @@pokemon << self
    @@pending_pokemon << self
    @hp = 60
    @database = nil
  end

  def type=(type)
    @type << type
  end

  def alter_hp(new_hp)
    self.hp = new_hp
    self.database.execute("UPDATE pokemon SET hp = #{new_hp} WHERE pokemon.name = '#{self.name}'")
  end

  def self.save(name, type, destination_database)
    self.reset
    this_pokemon = Pokemon.new(name)
    this_pokemon.type = type
    self.save_to_database(destination_database)
    self.reset
  end

  def self.save_to_database(database)
    @database = database.prepare("INSERT INTO pokemon (name, type, second_type) VALUES (?,?,?)")
    @@pending_pokemon.each{|pokemon|
      @database.execute pokemon.name, pokemon.type[0], pokemon.type[1]
    }
    self.reset
  end

  def self.find(poke_id, database)
    self.reset
    original_pokemon = database.execute("SELECT pokemon.name, pokemon.type FROM pokemon WHERE pokemon.id = #{poke_id}").flatten
    new_pokemon = self.new(original_pokemon[0])
    new_pokemon.type = original_pokemon[1]
    new_pokemon.database = database
    new_pokemon
  end

  def self.all
    @@pokemon
  end

  def self.reset
    @@pending_pokemon = []
  end

end