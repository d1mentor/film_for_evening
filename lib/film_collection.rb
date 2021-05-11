require 'rest-client'
require 'json'

class FilmCollection

  API_TOP_FILMS_URL = 'https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page='

  def initialize(films)
    @films = films
  end

  def self.from_kinopoisk
    films_hashes = []

    #Запрашиваем через апи топ фильмов
    for i in 1..15
      response = RestClient.get(API_TOP_FILMS_URL + i.to_s,
        header = { "X-API-KEY" => '012a078c-8f87-49e4-ad18-b5d3ec52de12' })
      #Парсим ответ в хэш
      response_hash = JSON.parse(response)
      films_hashes << response_hash['films']
      sleep(0.5)
    end

    #Создаем массив фильмов
    films = []

    films_hashes.each do |films_hash|
      films_hash.map { |film| films << Film.from_kinopoisk_hash(film) }
    end
    new(films)
  end

  def attributes_values(attribute)
    result = []
    @films.each do |film|

      if film.attributes[attribute].class == Array
        film.attributes[attribute].each { |string| result << string }
      else
        result << film.attributes[attribute]
      end
    end
    return result.uniq
  end

  def with_filter(filter_params)
    valide_films = []

    @films.each do |film|
      if film.valide?(filter_params)
        valide_films << film
      end
    end

    FilmCollection.new(valide_films)
  end

  def to_s
    result_str = "-"

    @films.each do |film|
      result_str += film.to_s
    end
  end

  def sample_film
    @films.sample.to_s
  end
end
