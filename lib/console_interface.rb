# Данный класс написан для возможности игры в терминале
# Содержит методы принимающие и возвращающие значения в терминал
class ConsoleInterface
  # Константа с путями к файлам с рисунками
  FIGURES =
    Dir["#{__dir__}/../data/figures/*.txt"]
    .sort
    .map { |file_name| File.read(file_name) }

  # Принимаем в конструктор экземпляр класса Игра
  def initialize(game)
    @game = game
  end

  # Возвращает состояние игры
  def print_out
    puts <<~GAME_STATUS
      Слово: #{word_to_show}
      #{figure}
      Ошибки (#{@game.errors_made}): #{errors_to_show}
      У вас осталось ошибок: #{@game.errors_allowed}

    GAME_STATUS

    if @game.won?
      puts 'Поздравляем, вы выиграли!'
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово #{@game.word}"
    end
  end

  # Метод возвращающий конкретный файл с рисунком исходя из количества ошибок
  def figure
    FIGURES[@game.errors_made]
  end

  # Выводит отгаданные буквы, закрывая неотгаданные
  def word_to_show
    @game.letters_to_guess.map { |letter| letter || '__' }.join(' ')
  end

  # Возвращает ошибочный ввод через запятую
  def errors_to_show
    @game.errors.join(', ')
  end

  # Запрашивает букву
  def get_input
    print 'Введите букву: '
    $stdin.gets[0].upcase
  end
end
