require 'sinatra'
require 'sinatra/reloader'


#Declared here so it doesn't change on refresh.
number = rand(100).to_s

get '/' do
  erb :index, :locals => {:number => number}

end
