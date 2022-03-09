# Класс игры
# Здесь прописана логика игры
class Game
  # Константа максимального количества ошибок
  TOTAL_ERRORS_ALLOWED = 7

  # В конструктор передаем слово для последующей работы с ним в классе
  def initialize(word)
    # Массив букв загаданного слова
    @letters = word.upcase.chars

    # Массив введённых пользователем букв
    @user_guesses = []
  end

  # Метод считает количество сделанных ошибок
  def errors_made
    errors.length
  end

  # Метод считает оставшиеся ошибки
  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  # Угаданные буквы
  def letters_to_guess
    @letters.map { |letter| letter if @user_guesses.include?(normalize_letter(letter)) }
  end

  # В методе хранятся неверно введённые буквы
  def errors
    @user_guesses - normalized_letters
  end

  # Метод проверки окончания игры
  def over?
    won? || lost?
  end

  # Метод принимает букву и добавляет её в массив введённых букв
  def play!(letter)
    # В случае, если игра не окончена и введённой буквы ещё не было
    return unless !over? && !@user_guesses.include?(normalize_letter(letter))

    # Буква добавляется в массив
    @user_guesses << normalize_letter(letter)
  end

  # Загаданное слово целиком
  def word
    @letters.join
  end

  # Метод проверки условия победы
  def won?
    (normalized_letters - @user_guesses).empty?
  end

  # Метод проверки условия поражения
  def lost?
    errors_allowed.zero?
  end

  # Заменяет Ё и Й на Е и И, в ином случае оставляет введённую букву нетронутой
  def normalize_letter(letter)
    case letter
    when 'Ё' then 'Е'
    when 'Й' then 'И'
    else letter
    end
  end

  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) }
  end
end
