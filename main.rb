require 'yaml'

word = ""
until word.length >= 5 && word.length <=12 do
word = File.readlines('google-10000-english-no-swears.txt')[rand(10000)].chomp.split('')
# print word ; puts
end
body_parts = 6
tracker = []
grave = []
(word.length).times do 
  tracker.push('_')
end
puts "new game - enter\nload game - \"load\" then enter\n(use \"save\" as your guess to save your game)"
puts "(use \"grave\" as your guess to see previous wrong guesses)"
if gets.chomp == "load"
 load_data = YAML.load_file('save.yaml')
 tracker = load_data[:tracker]
 body_parts = load_data[:body_parts]
 word = load_data[:word]
 grave = load_data[:grave]
end
until tracker == word || body_parts <= 0
  save_data = { :tracker => tracker, :word => word, :body_parts => body_parts, :grave => grave}
  correct_guess = nil
  puts "\nIncorrect Guesses Left : #{body_parts}\n"
  print tracker.join(' ') ; puts
  print "\nGuess? : "
  guess = gets.chomp.downcase
  if guess.length != 1 
    unless guess.downcase == "save" || guess.downcase == "grave"
      puts "One letter only dumbass"
      next
    end
    if guess.downcase == "save"
      File.write('save.yaml',save_data.to_yaml)
      p File.read('save.yaml')
    elsif guess.downcase == "grave"
      print grave.join(' ') ; puts "\n"
    end
    correct_guess = 'y'
  end
  word.length.times do |i|
    if word[i] == guess
      tracker[i] = guess
      correct_guess = 'y'
    end
  end
  unless correct_guess == 'y'
    puts "\nWRONG\n"
    grave.push(guess)
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


