require 'sinatra'
require 'sinatra/reloader'


#Declared here so it doesn't change on refresh.
random_number = rand(101).to_s

get '/' do
  "The secret number is #{random_number}"
end
