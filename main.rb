#настроили кодировку
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require 'hash_dig_and_collect'
require_relative 'lib/kinopoisk_api'
require_relative 'lib/film'

genres = KinopoiskAPI.films_parameters["genres"]
user_choice = ''
selected_genres_ids = []

until user_choice == 'exit'
  user_choice = gets.chomp

  if KinopoiskAPI.valid?(genres,user_choice)
    selected_genres_ids << KinopoiskAPI.genre_id_by_name(genres, user_choice)
  end
end

filter_url = KinopoiskAPI.genres_ids_array_to_url(selected_genres_ids)
films = KinopoiskAPI.films_by_genres(filter_url)

puts films.to_s
