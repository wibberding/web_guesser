require 'sinatra'
require 'sinatra/reloader'


#Class variables.
@@secret_number = rand(101) # 101 to include the number 100.
@@guesses_left = 5 +1 # "1" is to account for first page load.


get '/' do
  guess = params["guess"]
  cheat = params["cheat"]

  background_color = change_color(guess, @@secret_number) # intentional dependency injection. Is this the 'right way' to make the code clear, or is it better to just reference the class variable directly like check_guess()? Perhaps referencing a class variable is okay since you don't change it and there are no side effects??

  @@guesses_left -= 1 if guess !=""  # counts guesses and avoids changing on blank input.
  
  if @@guesses_left >= 5
    message = "Pick a number between 0 and 100."
  else
    message = check_guess(guess)
  end
  
  reset() if guess.to_i == @@secret_number # resets on correct guess.

  if @@guesses_left <= 0 # resets and displays message on end of game.
    message = "You lost. The number was #{@@secret_number.to_s}. A new number has been generated."
    reset()
  end

  erb :index, :locals => {:number => @@secret_number.to_s, :guess => guess.to_s, :message => message, :background_color => background_color, :guesses => @@guesses_left, :cheat => cheat}
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
  end
  message
end

def change_color(guess, number) 
  guess = guess.to_i
  spread = (guess - number).abs
  if spread == 0
    return "green"
  end
  
  offset = 7.1 # color steps offset.
  color_number = (13 - (spread / offset).floor)
  # format for hex values.
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
