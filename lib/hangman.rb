class Hangman
  attr_reader :guesser, :referee, :board

  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @board = Array.new(@referee.pick_secret_word)
  end
end

class HumanPlayer
end

class ComputerPlayer
  def initialize(dictionary)
    @dictionary = dictionary
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
end
