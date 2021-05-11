class Film
  attr_reader :attributes

  def initialize(args)
    @attributes = {
    "name" => args['name'],
    "year_of_issue" => args['year'],
    "genres" => args['genres'],
    "countries" => args['countries'] }
  end

  #Формат данных с АПИ немного специфичен, обрабатываем их
  def self.from_kinopoisk_hash(film_hash)
    genres = []
    countries = []

    #В хэше лежат хэши, разбираем эту конструкцию в удобоваримые строки
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

  #Проходит ли фильм через фильтр?
  def valide?(filter_params)
    filter_keys = filter_params.keys
    result = []

    #Проверяем по ключам фильтра
    filter_keys.each do |key|
      #Каждый элемент фильтра
      filter_params[key].each do |value|
        #Если есть вхождение в фильтр
        if @attributes[key].include?(value)
          result << true
          break
        end
      end
    end

    #Вхождения были у всех атрибутов?
    filter_keys.size == result.size
  end
end
