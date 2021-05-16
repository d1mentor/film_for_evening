require 'rest-client'
require 'json'

class KinopoiskAPI
  FILMS_PARAMETERS_ID_URL = 'https://kinopoiskapiunofficial.tech/api/v2.1/films/filters'
  FILMS_BY_PARAMETERS_URL = 'https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-filters?'
  TOKEN = { "X-API-KEY" => '012a078c-8f87-49e4-ad18-b5d3ec52de12' }
  #Количество страничек на кинопоиске, которые будут считаны
  PAGES_COUNT = 15

  def self.films_parameters
    response = RestClient.get(FILMS_PARAMETERS_ID_URL, header = TOKEN)
    films_parameters = JSON.parse(response)
  end

  def self.genre_id_by_name(array, name)
    array.map { |element| return element["id"] if element["genre"] == name }
  end

  def self.films_by_genres(filter)
    films = []

    PAGES_COUNT.times do |i|
      begin
      response = RestClient.get("#{FILMS_BY_PARAMETERS_URL}#{filter}page=#{i+1}",
        header = TOKEN)
      rescue RestClient::NotFound
        aviable = false
      end
      if aviable then films << JSON.parse(response)["films"] end
    end
    films
  end

  def self.genres_ids_array_to_url(array)
    "country=1,2,13&genre=#{array.join(',')}&order=RATING&type=ALL&ratingFrom=0&ratingTo=10&yearFrom=1888&yearTo=2020&"
  end

  def self.valid?(array, value)
    array.map { |element| return true if element.values.include?(value) }
    false
  end

end
