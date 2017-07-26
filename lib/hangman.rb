class Hangman
  attr_reader :guesser, :referee, :board

  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
  end

  def setup
    word_length = referee.pick_secret_word
    guesser.register_secret_length(word_length)
    @board = Array.new(word_length)
  end

  def take_turn
    guess = guesser.guess
    matching_idxs = referee.check_guess(guess)
    update_board(matching_idxs, guess)
    guesser.handle_response(board)
  end

  def update_board(matching_idxs, guess)
    matching_idxs.each do |match_idx|
      board[match_idx] = guess
    end
    board
  end
end

class HumanPlayer
end

class ComputerPlayer
  def initialize(dictionary)
    @dictionary = dictionary
    @guesses = []
  end

  def pick_secret_word
    @secret_word = @dictionary.sample
    @secret_word.length
  end

  def check_guess(guess)
    matching_idxs = []
    @secret_word.each_char.with_index do |ch, idx|
      matching_idxs << idx if guess == ch
    end
    matching_idxs
  end

  def register_secret_length(word_length)
    @word_length = word_length
  end

  def handle_response(board)

  end

  def guess(board)
    ("a".."z").reject {|let| @guesses.include?(let)}.sample
  end
end
