require 'sinatra'
require 'sinatra/reloader'


#Declared here so it doesn't change on refresh.
SECRET_NUMBER = rand(101)

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  erb :index, :locals => {:number => SECRET_NUMBER.to_s, :message => message}

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
