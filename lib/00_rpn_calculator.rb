class RPNCalculator
  def initialize
    @expression = []
  end

  def push(num)
    @expression << num
  end

  def empty_stack_error
    raise Exception, "calculator is empty"
  end

  def add_operator(operator)
    empty_stack_error unless @expression.size >= 2
    @expression << operator
  end

  def plus
     add_operator "+"
  end

  def minus
    add_operator '-'
  end

  def times
    add_operator '*'
  end

  def divide
    add_operator '/'
  end

  def tokens(expression)
    expression.split.map do |e|
    if e =~ /\d/
      e.to_i
    else
      e.to_sym
    end
    end
  end

  def value(expression=@expression) #evaluates all available operators with changing @expression
    expression = tokens(expression) if expression.is_a? String # ensure expression is in array/token form
    @stack = []
    expression.each do |e|
      if ['+', '-', '*', '/', :+, :-, :*, :/].include? e && @stack[-2].nil? #ensure there are sufficient operands
       empty_stack_error
      end
      case e
        when Numeric then @stack << e
        when "+", :+ then @stack << @stack.pop + @stack.pop
        when "-", :- then @stack << -(@stack.pop - @stack.pop)
        when "*", :* then @stack << @stack.pop * @stack.pop
        when "/", :/ then @stack << (1/(@stack.pop.to_f / @stack.pop))
      end
    end
    @stack.last
  end

  def evaluate(expression=@expression) # evaluates current or provided expression, resets @expression
    value(expression)
    raise Exception, "invalid expression, too many operands for number of operators" if @stack.size > 1
    @expression = []
    @stack.last
  end
end

