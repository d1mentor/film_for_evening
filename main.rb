#настроили кодировку
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'lib/film'
require_relative 'lib/film_collection'

def choice(attribute, collection)
  attributes = collection.attributes_values(attribute)

  attributes.each.with_index(1) do |attribute, index|
    puts "#{index}) #{attribute}"
  end

  result = []

  loop do
    print "Ввод:"
    choice = gets.chomp
    choice_num = choice.to_i
    return result if choice == 'next'

    if attributes[choice_num - 1] != nil && choice_num > 0
      result << attributes[choice_num - 1]
    end
    puts "Текущая конфигурация: #{result.uniq.to_s}"
  end
end

collection = FilmCollection.from_kinopoisk

puts 'приложение Кинопоиск для труъ консольщиков'
puts 'Настройте фильтр выдачи! Вводите номер элемента что бы выбрать его' \
  ' или \'next\' что бы продолжить'

puts 'Страны производства:'
selected_countries = choice("countries", collection)

puts 'Жанры:'
selected_genres = choice("genres", collection)

filter = {
  "genres" => selected_genres,
  "countries" => selected_countries }

valide_collection = collection.with_filter(filter)
puts valide_collection.to_s

