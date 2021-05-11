class Film
  attr_reader :attributes

  def initialize(args)
    @attributes = {
    "name" => args['name'],
    "year_of_issue" => args['year'],
    "genres" => args['genres'],
    "countries" => args['countries'] }
  end

  def self.from_kinopoisk_hash(film_hash)
    genres = []
    countries = []

    film_hash['genres'].each do |genre|
      genres << genre.values.last.to_s
    end

    film_hash['countries'].each do |country|
      countries << country.values.last.to_s
    end

    args = {
      "name" => film_hash['nameRu'],
      "year" => film_hash['year'],
      "genres" => genres,
      "countries" => countries }

    new(args)
  end

  def to_s
    "\'#{@attributes["name"]}\' - #{@attributes["genres"].join(', ')} " \
    "(#{@attributes["countries"].join(', ')} - #{@attributes["year_of_issue"]}г.)"
  end

  def valide?(filter_params)
    filter_keys = filter_params.keys
    result = []

    filter_keys.each do |key|
      filter_params[key].each do |value|
        if @attributes[key].include?(value)
          result << true
          break
        end
      end
    end

    filter_keys.size == result.size
  end
end
