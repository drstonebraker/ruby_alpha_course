# EASY

# Define a method that, given a sentence, returns a hash of each of the words as
# keys with their lengths as values. Assume the argument lacks punctuation.
def word_lengths(str)
  result = {}
  str.split.each do |word|
    result[word] = word.length
  end
  result
end

# Define a method that, given a hash with integers as values, returns the key
# with the largest value.
def greatest_key_by_val(hash)
  hash.sort_by{|k,v| v}.last.first
end

# Define a method that accepts two hashes as arguments: an older inventory and a
# newer one. The method should update keys in the older inventory with values
# from the newer one as well as add new key-value pairs to the older inventory.
# The method should return the older inventory as a result. march = {rubies: 10,
# emeralds: 14, diamonds: 2} april = {emeralds: 27, moonstones: 5}
# update_inventory(march, april) => {rubies: 10, emeralds: 27, diamonds: 2,
# moonstones: 5}
def update_inventory(older, newer)
  older.merge!(newer)
end

# Define a method that, given a word, returns a hash with the letters in the
# word as keys and the frequencies of the letters as values.
def letter_counts(word)
  letters = Hash.new(0)
  word.chars.each do |ch|
    letters[ch] += 1
  end
  letters
end

# MEDIUM

# Define a method that, given an array, returns that array without duplicates.
# Use a hash! Don't use the uniq method.
def my_uniq(arr)
  arr.map{|el| [el, true]}.to_h.keys
end

# Define a method that, given an array of numbers, returns a hash with "even"
# and "odd" as keys and the frequency of each parity as values.
def evens_and_odds(numbers)
  result = Hash.new(0)
  numbers.each do |num|
    if num.even?
      result[:even] += 1
    else
      result[:odd] += 1
    end
  end
  result
end

# Define a method that, given a string, returns the most common vowel. If
# there's a tie, return the vowel that occurs earlier in the alphabet. Assume
# all letters are lower case.
def most_common_vowel(string)
  counts = Hash.new(0)
  string.scan(/[aeiou]/).each do |vowel|
    counts[vowel] += 1
  end
  counts.sort_by{|k,v| [-v, k]}.first.first
end

# HARD

# Define a method that, given a hash with keys as student names and values as
# their birthday months (numerically, e.g., 1 corresponds to January), returns
# every combination of students whose birthdays fall in the second half of the
# year (months 7-12). students_with_birthdays = { "Asher" => 6, "Bertie" => 11,
# "Dottie" => 8, "Warren" => 9 }
# fall_and_winter_birthdays(students_with_birthdays) => [ ["Bertie", "Dottie"],
# ["Bertie", "Warren"], ["Dottie", "Warren"] ]
def fall_and_winter_birthdays(students)
  students.select {|k,v| v.between?(7,12)}
    .map {|(k,v)| k}
    .combination(2)
    .to_a
end

# Define a method that, given an array of specimens, returns the biodiversity
# index as defined by the following formula: number_of_species**2 *
# smallest_population_size / largest_population_size biodiversity_index(["cat",
# "cat", "cat"]) => 1 biodiversity_index(["cat", "leopard-spotted ferret",
# "dog"]) => 9
def biodiversity_index(specimens)
  specimen_count = Hash.new(0)
  specimens.each{|specimen| specimen_count[specimen] += 1}
  number_of_species = specimen_count.length
  smallest_population_size = specimen_count.min_by{|k,v| v}.last
  largest_population_size = specimen_count.max_by{|k,v| v}.last

  number_of_species**2 * smallest_population_size / largest_population_size
end

# Define a method that, given the string of a respectable business sign, returns
# a boolean indicating whether pranksters can make a given vandalized string
# using the available letters. Ignore capitalization and punctuation.
# can_tweak_sign("We're having a yellow ferret sale for a good cause over at the
# pet shop!", "Leopard ferrets forever yo") => true
def can_tweak_sign?(normal_sign, vandalized_sign)
  normal_sign = normal_sign.dup.downcase
  vandalized_sign = vandalized_sign.dup.downcase

  character_count(vandalized_sign).all? do |k,v|
    v <= character_count(normal_sign)[k]
  end
end

def character_count(str)
  count = Hash.new(0)
  str.chars.each{|ch| count[ch] += 1}
  count
end
