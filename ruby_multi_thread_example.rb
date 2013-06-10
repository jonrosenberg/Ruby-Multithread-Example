#!/usr/bin/ruby
require 'thread'

LENGTH = 1000

puts "multi-thread example"

@ary = [0]
@ary *= LENGTH

@i = 0
@t1_count = 0
@t2_count = 0

mutex = Mutex.new
cv = ConditionVariable.new

def inc
	#cv.wait(mutex)
	@ary[@i] += 1
	@i += 1
	#cv.signal
end


puts "Started At #{Time.now}"
t1=Thread.new{
	puts "t1 at: #{Time.now}"
	begin
		mutex.synchronize do
			inc
		end
		@t1_count += 1
		sleep(0.00055)

	end while @i < LENGTH
	puts "t1 at: #{Time.now}"
}

t2=Thread.new{
	puts "t2 at: #{Time.now}"
	begin
		mutex.synchronize do
			inc()
		end
		@t2_count += 1
		sleep(0.0005)
	end while @i < LENGTH
	puts "t2 at: #{Time.now}"
}
t1.join
t2.join
puts "End at #{Time.now}"

puts "ary :  #{@ary}"
puts "total :  #{@i}"
puts "t1_count :  #{@t1_count}"
puts "t2_count :  #{@t2_count}"

mutex.lock

