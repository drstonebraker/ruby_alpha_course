def find_word(word)
  chars = word.chars.map {|ch| ch == '_' ? nil : ch}
  dictionary = File.readlines('./lib/dictionary.txt')
  candidates = dictionary.select do |candidate|
    chars.all? do |word_ch|
      word_ch.nil? || get_matching_idxs(word, word_ch) == get_matching_idxs(candidate, word_ch)
    end
  end
  p candidates
end

def get_matching_idxs(word, guess)
  matching_idxs = []
  word.each_char.with_index do |ch, idx|
    matching_idxs << idx if guess == ch
  end
  matching_idxs
end

if __FILE__ == $0
  find_word(ARGV[0])
end
