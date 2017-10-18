class Timer
  attr_accessor :seconds

  def initialize
    @seconds = 0
  end

  def time_string
    minutes, seconds = @seconds.divmod(60)
    hours, minutes = minutes.divmod(60)
    "%02d:%02d:%02d" % [hours, minutes, seconds]
  end

end
