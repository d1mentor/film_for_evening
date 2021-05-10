class Film
  attr_reader :attributes

  def initialize(args)
    @attributes = {
      "name" => args['nameRu'],
      "year_of_issue" => args['year'],
      "genres" => args['genres'],
      "countries" => args['countries'] }
  end

  def to_s
    "#{@attributes["name"]}"
  end

  def valide?(filter_params)
    genres_valide = true
    countries_valide = true

    @attributes["genres"].each do |arr|

    unless filter_params["genres"].include?(arr.values.last)
      genres_valide = false
      next
    end
    end

    @attributes["countries"].each do |arr|

    unless filter_params["countries"].include?(arr.values.last)
      countries_valide = false
    end
    end
    genres_valide && countries_valide
  end

end
