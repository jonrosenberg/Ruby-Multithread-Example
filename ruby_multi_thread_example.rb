#!/usr/bin/ruby
require 'thread'

LENGTH = 1000

puts "multi-thread example"
@mutex = Mutex.new

#Create array of size 1000 and initiate the values to zero
@ary = [0]
@ary *= LENGTH

@i = 0
@t1_count = 0
@t2_count = 0

# Increment the next element in the array
def increment
	@mutex.lock 		# Lock code block
		@ary[@i] += 1
		@i += 1
	@mutex.unlock 		# Unlock code block
	sleep(0.000002)		# Put thread to sleep briefly to prove multi-thread functionality
end

# Run thread 1
puts "Started At #{Time.now}"
t1=Thread.new do
	begin
		if(@i < LENGTH)			# Protect from array out of bounds
			increment()
			@t1_count += 1 		# Count number of times thread 1 incremented array
		end
	end while @i < LENGTH
	puts "t1 ends at: #{Time.now}"
end

# Run thread 2
t2=Thread.new do
	begin
		if(@i < LENGTH)			# Protect from array out of bounds
			increment()
			@t2_count += 1 		# Count number of times thread 2 incremented array
		end
	end while @i < LENGTH
	puts "t2 ends at: #{Time.now}"
end

t1.join
t2.join
puts "End at #{Time.now}"

puts "ary :  #{@ary}"
puts "total :  #{@i}"
puts "thread 1 increment count :  #{@t1_count}"
puts "thread 2 increment count :  #{@t2_count}"



