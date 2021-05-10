#настроили кодировку
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
#Подключили класс
require_relative 'lib/film'
#Пути к файлам
files_list = Dir.glob("#{__dir__}/data/*.txt")

films_collection = files_list.map { |path| File.readlines(path, encoding: 'UTF-8', chomp: true) }
films_collection = films_collection.map { |film| Film.new(film[0], film[1], film[2].to_i) }

puts "Фильм какого режисера вы хотите сегодня посмотреть?"

produsers_list = films_collection.map { |film| film.producer }.uniq

produsers_list.each_with_index do |producer, index|
  puts "#{index + 1}. #{producer}"
end

user_choice = 0

until (1..produsers_list.size).include?(user_choice) do
  print "Введите номер режисера:"
  user_choice = gets.to_i
end

choice_producer = produsers_list[user_choice - 1]

current_films = films_collection.select { |film| film.producer == choice_producer }

random_film = current_films.sample
puts "#{random_film.producer} - #{random_film.name} (#{random_film.year_of_issue})"
