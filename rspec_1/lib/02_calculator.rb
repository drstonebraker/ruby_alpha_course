def add(num1, num2)
    num1 + num2
end

def subtract(num1, num2)
    num1 - num2
end

def sum(nums)
    nums.inject(:+) || 0 # conditional 0 covers empty array argument
end

def multiply(*nums)
    nums.inject(:*)
end

def power(num1, num2)
    num1 ** num2
end

def factorial(num)
    num < 0 ? nil : (2..num).to_a.inject(:*) || 1 #conditional 1 covers 0! and 1!
end
