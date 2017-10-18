class HumanPlayer
  def get_play
    puts "Enter coordinates"
    $stdin.gets.chomp.split(/\,\s*/).map(&:to_i)
  end
end
