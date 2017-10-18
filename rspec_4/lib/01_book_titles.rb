class Book
  attr_reader :title

  def title=(title)
    @title = titleize(title)
  end
  private

  def titleize(input_s)
    little_words_arr = %W(a an and the over in of)
    words_arr = input_s.split.map.with_index do |word_s, idx|
      if idx.zero? || !little_words_arr.include?(word_s)
        word_s.capitalize
      else
        word_s.downcase
      end
    end
    words_arr.join(" ")
  end
end
