class Dictionary
  attr_reader :entries

  def initialize
    @entries = {}
  end

  def add(hash)
    if hash.is_a? Hash
      @entries = @entries.merge(hash){|key, oldval, newval| newval}
    else
      @entries[hash] = nil
    end
  end

  def keywords
    @entries.keys.sort
  end

  def include?(keyword)
    keywords.include?(keyword)
  end

  def find(keyword)
    Hash[@entries.find_all{|key, val| key.include?(keyword)}]
  end

  def printable
    result = ""
    keywords.each do |word|
      result += "[#{word}] \"#{@entries[word]}\"\n"
    end
    result.strip
  end
end

