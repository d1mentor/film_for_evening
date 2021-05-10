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
    for i in 1..10
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
      films_hash.map { |film| films << Film.new(film) }
    end
    new(films)
  end

  def attributes_values(attribute)
    values = []

    #Записываем значение атрибута, каждого фильма коллекции (Все названия например)
    @films.each do |film|
      values << film.attributes[attribute]
    end

    values_strings = []

    # Так как атрибутом может быть массив хэшей, обрабатываем такой случай
    values.each do |element|

      if element.class == Array # В массиве в любом случае хэши
        #Записываем значение каждого хэша
        element.map { |sub_element| values_strings << sub_element.values.last.to_s }
      else
        #Если элемент не массив, то просто записываем в результат
        values_strings << element.to_s
      end
    end

    #Возвращаем результат в виде массива уникальных строк
    values_strings.uniq
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

end
