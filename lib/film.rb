class Film
  attr_reader :attributes

  def initialize(args)
    @name = args["name"]
    @year = args["year"].to_i
    @genres = args["genres"].join(', ')
    @countries = args["countries"].join(', ')
  end

  def to_s
    "#{@name} - #{year}\nЖанр:#{@genres}\nСтраны:#{countries}\n"
  end

  def self.from_kinopoiskAPI(hash)
  end

end
