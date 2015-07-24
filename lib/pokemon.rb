class Pokemon

  def save(pkname, pktype, db)
  db.execute "INSERT INTO pokemon (name, type) VALUES (pkname, pktype)"
  end

end