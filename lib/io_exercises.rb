# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
  answer = rand(1..100)
  guess_count = 0
  guess = ''

  loop do
    guess_count += 1
    puts 'Guess a number from 1 to 100'
    guess = gets.chomp.to_i

    if guess < answer
      puts "#{guess} is too low. Try again. (Guess #{guess_count})"
    elsif guess > answer
      puts "#{guess} is too high. Try again. (Guess #{guess_count})"
    else
      break
    end
  end

  puts "#{guess} is the right number! (Guess #{guess_count})"
  true
end

def file_shuffler
  puts 'Please type the name of a txt file to shuffle:'
  user_filename = gets.chomp

  lines = File.readlines(user_filename).shuffle

  new_filename = user_filename.sub(/\.txt$/, '-shuffled.txt')
  new_file = File.open(new_filename, 'w') do |file|
    lines.each {|line| file.puts(line)}
  end
  puts "File shuffled and saved as #{new_filename}"
  new_file
end

if __FILE__ == $0
  file_shuffler
end
