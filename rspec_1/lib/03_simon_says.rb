def echo(message)
   message
end

def shout(message)
   message.upcase
end

def repeat(message, num_repeats=2)
   ((message + ' ') * num_repeats).strip
end

def start_of_word(word, sublength=1)
    word[0, sublength]
end

def first_word(sentence)
    sentence.split.first
end

def titleize(title)
    little_words = %w{a an the at by for in of on to up and as but or over nor}
    title.capitalize.split.map {|word| little_words.include?(word) ? word : word.capitalize}.join(' ')
end
