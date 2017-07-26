class Hangman
  attr_reader :guesser, :referee, :board
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
end
