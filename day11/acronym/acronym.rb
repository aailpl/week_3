require 'sinatra'

# def makeAcronym(sentence)
# 	return "Not a string" unless sentence.is_a?(String)

# 	sentence.split.map do |word|
# 		word[0].upcase
# 	end.join
		
# end


# get '/' do
# 	@acronym= ""
# 	erb :form
# end

# post '/' do
# 	@acronym = makeAcronym(params[:sentence])
# 	erb :form
# end

def make_acronym(string)
	first_letter= []

	if string.to_i !=0
		"Not letters"
	else
		array = string.split

		array.each do |letter|
			first_letter << letter.chr.upcase
		end
		"#{first_letter.join}"
end

get '/' do
	if params[:word] != nil
		@word = make_acronym(params[:word])
	end
	erb :form
end