def reverser
	yield.gsub(/\w+/){|m| m.reverse}
end

def adder(input=1)
	input + yield
end

def repeater(repeats=1)
	repeats.times{yield}
end
