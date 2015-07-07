require 'sinatra'

# get '/' do
# 	if params.key?('age')
# 		if params[:age].to_i < 18
# 			@answer = "You're not allowed to drink!"
# 		else
# 			@answer = "You're allowed to drink!"
# 		end
# 	end
# 	erb :form
# end
def can_drink(age)
	if age >= 18
		"Allowed to drink"
	else
		"not allowed to drink"
	end
end


get '/' do
	erb :form
end

get '/answer' do
	@message = can_drink(params[:age].to_i)
	erb :answer
end