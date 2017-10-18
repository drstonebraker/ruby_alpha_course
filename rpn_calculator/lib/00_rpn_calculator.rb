class RPNCalculator
  def initialize
    @stack = []
  end

  def push(val)
    @stack << val.to_f
  end

  def value
    @stack.last
  end

  def test_length
    raise Exception, "calculator is empty" if @stack.length <= 1
  end

  def operate(operator)
    test_length
    @stack[-2..-1] = @stack.last(2).inject(operator)
  end

  def plus
    operate(:+)
  end

  def minus
    operate(:-)
  end

  def times
    operate(:*)
  end

  def divide
    operate(:/)
  end

  def tokens(token_string)
    token_string.split.map do |char_s|
      if char_s =~ /[0-9]/
        char_s.to_i
      else
        char_s.to_sym
      end
    end
  end

  def evaluate(token_string)
    stack = RPNCalculator.new
    tokens(token_string).each do |token|
      case token
        when Fixnum then stack.push(token)
        when Symbol then stack.operate(token)
      end
    end
    stack.value
  end
end

