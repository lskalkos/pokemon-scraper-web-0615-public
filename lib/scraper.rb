

class Scraper
  attr_reader :db

  def initialize(db)
    @db = db
  end

  def scrape
    html = open("./pokemon_index.html")
    doc = Nokogiri::HTML(html)
    pokemon = doc.css("span.infocard-tall")

    sql = <<-SQL
      INSERT INTO pokemons (name, type) VALUES (?, ?);
    SQL

    pokemon.each do |pokemon_n|
      name = pokemon_n.css("a.ent-name").text
      type = pokemon_n.css(".aside").children.text.split(" · ").first

      db.execute(sql, name, type)
    end
  end

end

