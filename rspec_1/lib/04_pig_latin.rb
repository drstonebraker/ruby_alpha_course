def pig_latinize(word)
    vowels = %w{a e i o u}
    is_capitalized = word[0] == word[0].upcase
    first_vowel = word.chars.index {|char| vowels.include?(char)}
    first_vowel ||= word.index('y')
    return word unless first_vowel
    first_vowel += 1 if word[first_vowel-1, 2].downcase == "qu"

    word = word[first_vowel..-1] + word[0...first_vowel] + "ay"

    word.capitalize! if is_capitalized

    word
end



def translate(sentence)
    sentence.split(/\b/).map {|word| pig_latinize(word)}.join
end
