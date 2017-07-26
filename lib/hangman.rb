require 'byebug'
class Hangman
  attr_reader :guesser, :referee, :board

  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @misses_left = 7
  end

  def play
    setup
    until result = game_over?
      take_turn
    end
    guesser.game_over_msg(result)
  end

  private

  def setup
    word_length = referee.pick_secret_word
    guesser.register_secret_length(word_length)
    @board = Array.new(word_length)
  end

  def take_turn
    guess = guesser.guess
    matching_idxs = referee.check_guess(guess)
    update_board(matching_idxs, guess)
    update_misses_left(matching_idxs)
    draw_hangman
    print_board
    guesser.handle_response(guess, matching_idxs)
  end

  def update_board(matching_idxs, guess)
    matching_idxs.each do |match_idx|
      board[match_idx] = guess
    end
    board
  end

  def update_misses_left(matching_idxs)
    @misses_left -= 1 if matching_idxs.empty?
  end

  def game_over?
    if board == board.compact
      'win'
    elsif @misses_left == 0
      'tie'
    else
      false
    end
  end

  def draw_hangman
    rope = @misses_left > 6 ? ' ' : '|'
    head = @misses_left > 5 ? ' ' : 'O'
    body = @misses_left > 4 ? ' ' : '|'
    left_arm = @misses_left > 3 ? ' ' : '/'
    right_arm = @misses_left > 2 ? ' ' : "\\"
    left_leg = @misses_left > 1 ? ' ' : '/'
    right_leg = @misses_left > 0 ? ' ' : "\\"

    puts "_" * 9
    puts "|#{' ' * 9}#{rope}"
    puts "|#{' ' * 9}#{head}"
    puts "|#{' ' * 8}#{left_arm}#{body}#{right_arm}"
    puts "|#{' ' * 8}#{left_leg} #{right_leg}"
    puts "|"
    puts "|"

    puts "#{@misses_left} wrong guesses left"
  end

  def print_board
    board.each do |space|
      print (space || '_')
    end
    puts "\n"
  end

end

class HumanPlayer

  def initialize(dictionary)
    @guesses = []
  end

  # public guesser methods

  def handle_response(guess, matching_idxs); end

  def guess(board)
    puts "Guess a letter:"
    gets.chomp[0]
  end

  def game_over_msg(result)
    if result == 'win'
      puts 'You have won!'
      true
    else
      puts 'You have lost =('
      false
    end
  end

  # public referee methods

  def pick_secret_word
    puts "Think of a secret word for the computer to guess"
    puts "Please type the number of letters in your word:"
    gets.chomp.to_i
  end

  def check_guess(guess)
    puts "The computer has guessed '#{guess}'."
    puts "Please type all the indexes (separated by commas)" \
    " where this letter exists in your secret word" \
    " or press enter if your word does not contain the letter"
    gets.chomp.split(/\,*\s*/).map(&:to_i)
  end

  def register_secret_length(word_length)
    @word_length = word_length
  end

  private

  #private guesser methods

  #private referee methods

end

class ComputerPlayer
  attr_reader :candidate_words

  def initialize(dictionary=nil)
    @dictionary = dictionary || File.readlines('dictionary.txt')
    @guesses = []
  end

  # public guesser methods

  def handle_response(guess, matching_idxs)
    update_candidate_words(guess, matching_idxs)
  end

  def guess(board)
    available_chars = candidate_words.join.chars
    available_chars.reject! do |ch|
      @guesses.include?(ch) || board.include?(ch)
    end
    available_chars.max_by {|ch| available_chars.count(ch)}
  end

  def game_over_msg(result)
    if result == 'win'
      puts 'The computer has guessed your word!'
      true
    else
      puts 'The hangman is complete. You have fooled the computer!'
      false
    end
  end

  # public referee methods

  def pick_secret_word
    @secret_word = @dictionary.sample
    @secret_word.length
  end

  def check_guess(guess)
    get_matching_idxs(@secret_word, guess)
  end

  def register_secret_length(word_length)
    @word_length = word_length
    @candidate_words = get_candidate_words
  end

  private

  #private guesser methods

  def update_candidate_words(guess, matching_idxs)
    @candidate_words = candidate_words.reject do |word|
      get_matching_idxs(word, guess) != matching_idxs
    end
  end

  def get_candidate_words
    @dictionary.reject {|word| word.length != @word_length}
  end

  #private referee methods

  def get_matching_idxs(word, guess)
    matching_idxs = []
    word.each_char.with_index do |ch, idx|
      matching_idxs << idx if guess == ch
    end
    matching_idxs
  end

end
