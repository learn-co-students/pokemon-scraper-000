class SQLRunner
  def initialize(db)
    @db = db
  end

  def execute_schema_migration_sql
    sql = File.read('db/schema_migration.sql')
    execute_sql(sql)
  end

  def execute_sql(sql)
     sql.scan(/[^;]*;/m).each { |line| @db.execute(line) } unless sql.empty?
  end

  def execute_create_hp_column
    @db.execute('ALTER TABLE pokemon_table ADD COLUMN hp INTEGER')
    @db.execute('UPDATE pokemon_table SET hp = 60')
  end

end