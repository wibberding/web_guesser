require 'sinatra'
require 'sinatra/reloader'


#Declared here so it doesn't change on refresh.
SECRET_NUMBER = rand(101) # 101 to include the number 100.
@@guesses_left = 5


get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  background_color = change_color(guess, SECRET_NUMBER) # intentional dependency injection. Is this the 'right way' to make the code clear, or is it better to just reference the constant directly like check_guess()? Perhaps referencing a constant is okay since you don't change it and there are no side effects??
  erb :index, :locals => {:number => SECRET_NUMBER.to_s, :message => message, :background_color => background_color, :guesses => @@guesses_left}

end

def check_guess(guess)
  if (guess - SECRET_NUMBER) > 5
    message = "Way too high!"
  elsif (SECRET_NUMBER - guess) > 5
    message = "Way too low!"
  elsif guess > SECRET_NUMBER
    message = "Too high!"
  elsif guess < SECRET_NUMBER
    message = "Too low!"
  else
    message = "You got it right!"
  end
  message
end

def change_color(guess, number) 
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
