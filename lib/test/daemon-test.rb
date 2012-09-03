
loop do
  open('/Users/tmalvey/Sites/craigs-class/lib/test/myfile.out', 'a') do |f|
    f.puts "Hello, world. It's me again."
  end

  sleep(5)
end