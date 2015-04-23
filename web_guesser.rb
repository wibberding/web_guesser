require 'sinatra'
require 'sinatra/reloader'


#Declared here so it doesn't change on refresh.
@@secret_number = rand(101) # 101 to include the number 100.
@@guesses_left = 5


get '/' do
  guess = params["guess"]
  @@guesses_left -= 1 if guess !=""  #counts guesses and avoids changing on blank input.
  message = check_guess(guess)

  if @@guesses_left <= 0 
    message = "You lost. I new number has been generated."
    reset()
  end

  background_color = change_color(guess, @@secret_number) # intentional dependency injection. Is this the 'right way' to make the code clear, or is it better to just reference the class variable directly like check_guess()? Perhaps referencing a class variable is okay since you don't change it and there are no side effects??
  erb :index, :locals => {:number => @@secret_number.to_s, :message => message, :background_color => background_color, :guesses => @@guesses_left}

end

def check_guess(guess)
  guess = guess.to_i
  if (guess - @@secret_number) > 5
    message = "Way too high!"
  elsif (@@secret_number - guess) > 5
    message = "Way too low!"
  elsif guess > @@secret_number
    message = "Too high!"
  elsif guess < @@secret_number
    message = "Too low!"
  else
    message = "You got it right! A new number has been generated"
    reset()
  end
  message
end

def change_color(guess, number) 
  guess = guess.to_i
  spread = (guess - number).abs
  if spread == 0
    return "green"
  end
  
  offset = 7.1 # number of color steps 
  color_number = (13 - (spread / offset).floor)
  color_number = "a" if color_number == 10
  color_number = "b" if color_number == 11
  color_number = "c" if color_number == 12
  color_number = "d" if color_number == 13
  color_number.to_s

  return "#f#{color_number}#{color_number}"
end

def reset()
  @@guesses_left = 5
  new_number = rand(101)
  @@secret_number = new_number
end
