class Pokemon
  attr_accessor :db

  def initialize(db = nil)
    @db = db
  end

  def save(pkname, pktype, db)
  preparedDB = db.prepare("INSERT INTO pokemon (name, type) VALUES (?, ?)")
  preparedDB.execute(pkname, pktype)
  end

end

# Just trying to add it again