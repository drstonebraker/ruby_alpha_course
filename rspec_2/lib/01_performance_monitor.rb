def measure(repeats=1)
	times = []
	repeats.times do
		start = Time.now
		yield
		times << Time.now - start
	end
	times.inject(0, :+) / times.length
end
