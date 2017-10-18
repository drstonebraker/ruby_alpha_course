class Fixnum
  def in_words(punctuate=false)
    return "zero" if self.zero?
    result = []

    xillions = 1_000_000_000_000
    divmodder = [self]
    comma = punctuate ? ',' : ''

    %w{trillion billion million thousand}.each do |xillion|
      divmodder = divmodder.last.divmod(xillions)
      result += [first_thousand_words(divmodder.first, punctuate), xillion + comma] unless divmodder.first.zero?
      xillions /= 1000
    end

    result << first_thousand_words(divmodder.last, punctuate)

    result = result.join(' ').strip.gsub('- ', '-')
    result.chop! if result[-1] == ','
    result
  end

  private
  def teens_word(num)
    case num
      when 10 then "ten"
      when 11 then "eleven"
      when 12 then "twelve"
      when 13 then "thirteen"
      when 14 then "fourteen"
      when 15 then "fifteen"
      when 16 then "sixteen"
      when 17 then "seventeen"
      when 18 then "eighteen"
      when 19 then "nineteen"
    end
  end

  def ones_word(num)
    case num
      when 1 then "one"
      when 2 then "two"
      when 3 then "three"
      when 4 then "four"
      when 5 then "five"
      when 6 then "six"
      when 7 then "seven"
      when 8 then "eight"
      when 9 then "nine"
    end
  end

  def tens_word(num)
    case num
      when 20 then "twenty"
      when 30 then "thirty"
      when 40 then "forty"
      when 50 then "fifty"
      when 60 then "sixty"
      when 70 then "seventy"
      when 80 then "eighty"
      when 90 then "ninety"
    end
  end

  def first_thousand_words(num, punctuate=false)
    result = []

    hundreds = num.divmod(100)
    tens   = hundreds.last.divmod(10)
    ones   = tens.last

    result += [ones_word(hundreds.first), 'hundred'] unless hundreds.first.zero?

    if (10..19).include?(hundreds.last)
      result << teens_word(hundreds.last)
    else
      unless tens.first.zero?
      	result << tens_word(tens.first * 10) + ((!ones.zero? && punctuate) ? '-' : '')
      end
      result << ones_word(ones) unless ones.zero?
    end

    result.join(' ').strip
  end


end

