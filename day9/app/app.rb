require 'sinatra'

get '/' do
	'Hello world'
end

get '/about' do
	"Hello Ana."
end

get '/hello/:name :city' do
	"hello #{params[:name]} from #{params[:city]}"
	params.keys.join(' ')
end

get '/form' do
	erb :form
end

get '/submission' do
	"hello #{params[:name]} you are #{params[:idade]} years old"
end