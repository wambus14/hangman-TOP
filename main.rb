require 'yaml'

word = ""
until word.length >= 5 && word.length <=12 do
word = File.readlines('google-10000-english-no-swears.txt')[rand(10000)].chomp.split('')
# print word ; puts
end
body_parts = 6
tracker = []
(word.length).times do 
  tracker.push('_')
end
puts "new game - enter\nload game - \"load\" then enter\n(put \"save\" as your guess to save your game)"
if gets.chomp == "load"
 load_data = YAML.load_file('save.yaml')
 tracker = load_data[:tracker]
 body_parts = load_data[:body_parts]
 word = load_data[:word]
end
until tracker == word || body_parts <= 0
  save_data = { :tracker => tracker, :word => word, :body_parts => body_parts}
  correct_guess = nil
  puts "\nIncorrect Guesses Left : #{body_parts}\n"
  print tracker.join(' ') ; puts
  print "\nGuess? : "
  guess = gets.chomp.downcase
  if guess.length != 1 
    if guess.downcase == "save"
      File.write('save.yaml',save_data.to_yaml)
      p File.read('save.yaml')
    end
    puts "One letter only dumbass"
    next
  end
  word.length.times do |i|
    if word[i] == guess
      tracker[i] = guess
      correct_guess = 'y'
    end
  end
  unless correct_guess == 'y'
    puts "\nWRONG\n"
    body_parts -= 1
  end
end
print tracker.join(' ') ; puts 
if body_parts > 0 
  puts "\nyay you win"
else
  puts "\nyou died :("
  puts "Word was #{word.join('')}"
end


