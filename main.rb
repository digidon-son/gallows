require_relative 'lib/console_interface'
require_relative 'lib/game'

puts 'Всем привет!'

# Загрузка случайного слова из файла
word = File.readlines("#{__dir__}/data/words.txt", chomp: true).sample

# Создание экземпляров классов
# Классу игры передается слово
game = Game.new(word)

# Классу интерфейса экземпляр класса игры
console_interface = ConsoleInterface.new(game)

# Пока не закончилась игра
until game.over?
  # Вывести очередное состояние игры
  console_interface.print_out
  # Спросить очередную букву
  letter = console_interface.get_input
  # Обновить состояние игры
  game.play!(letter)
end

# Вывести результат
console_interface.print_out
