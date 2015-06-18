
class Pokemon
  attr_accessor :name, :type, :hp, :db, :id

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemons (name, type) VALUES (?, ?);
    SQL

    db.execute(sql, name, type)
  end

  def self.find(id, db)

    sql = <<-SQL
      SELECT * FROM pokemons WHERE id = ?;
    SQL

    result = db.execute(sql, id)
    id = result.first[0]
    name = result.first[1]
    type = result.first[2]

    Pokemon.new.tap do |pokemon|
      pokemon.id = id
      pokemon.name = name
      pokemon.type = type
      pokemon.db = db
    end

  end

  def alter_hp(new_hp)
    self.hp = new_hp
    self.update
  end

  def update
    sql = <<-SQL
        UPDATE pokemons
        SET name = ?, type = ?, hp = ?
        WHERE id = ?;
    SQL

    self.db.execute(sql, self.name, self.type, self.hp, self.id)
  end


end


