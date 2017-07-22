class ComputerPlayer
  attr_reader :name

  def initialize(name=nil)
    @name = name || 'Computer'
  end
end
