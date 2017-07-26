class Hangman
  attr_reader :guesser, :referee, :board
end

class HumanPlayer
end

class ComputerPlayer
  def initialize(dictionary)
    @dictionary = dictionary
    @secret_word = @dictionary.sample
    @guessing_board = Array.new(pick_secret_word)
  end

  def pick_secret_word
    @secret_word.length
  end

  def check_guess(guess)
    matching_idxs = []
    @secret_word.each_char.with_index do |ch, idx|
      matching_idxs << idx if guess == ch
    end
    matching_idxs
  end
end
