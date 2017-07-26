class Hangman
  attr_reader :guesser, :referee, :board
end

class HumanPlayer
end

class ComputerPlayer
  def initialize(dictionary)
    @dictionary = dictionary
  end
end
