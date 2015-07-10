require 'sinatra'
require 'date'

class Party

	attr_reader :name, :date, :location, :id
	attr_writer :name, :location

	def initialize(hash)
		@name = hash[:name]
		@date = hash[:date]
		@location = hash[:location]
		@id = hash[:id]
	end

	def date=(date)
		@date = convert_time(date)
	end
end

def convert_time(date) #yyyy-dd-mmThh:mm
	DateTime.strptime(date,"%Y-%m-%dT%H:%M")	
end

parties = [
	Party.new({:id => 0,:name => "DnB Blast", :date => DateTime.new(2015,7,8,16,19), :location => "Braga"}),
	Party.new({:id => 1,:name => "WTH", :date => DateTime.new(2015,8,7,17,17), :location => "Porto"}),
	Party.new({:id => 2,:name => "EDM", :date => DateTime.new(2015,9,6,18,15), :location => "Lisbon"}),
	Party.new({:id => 3,:name => "Mega Elctro", :date => DateTime.new(2015,10,5,19,13), :location => "Coimbra"})
]


# list of all parties
get '/' do

	if params.key?("search_by")
		select = parties.select do |party|
			(party.send params[:search_by].to_sym).upcase  == params[:search].upcase
		end

		if select.empty?
			redirect '/error'
		else
			@parties = select
		end
		
	else
		@parties = parties
	end
  
  erb :index
end
post '/' do

end
# form to create a new party
get '/new' do
  erb :new
end

# method to save a new party, the /new route should point here
post '/create' do
  time = convert_time(params[:date])
  index = parties.last.id + 1
  parties << Party.new({:id => index,:name => params[:name], :date => time, :location => params[:location]}) 
  redirect '/'
end

get '/error' do
   status 404
  'not found'
end

# show individual post
get '/:id' do
  @party = 	parties.find do |party|
  	party.id == params[:id].to_i
  end

  erb :show
end

# form to edit a single party
get '/:id/edit' do
	@party = parties.find do |party|
  		party.id == params[:id].to_i
  	end

  	@edit_mode = params.keys[0]

  	if @edit_mode == "date"
  		@edit_type = "datetime-local"
  	else
  		@edit_type = "text"
  	end
  	#@edit_mode=="Date" ? "datetime-local" : "text"

	erb :edit	
end


# method to update an existing party, the /:id/edit should point here
post '/:id/update' do
	party = parties.find do |party|
  		party.id == params[:id].to_i
  	end

  	keys = params.keys

  	keys.each do |key|
  		s = (key + '=').to_sym 
  		if party.respond_to?(s)
  			party.send s, params[key.to_sym]
  		end
  	end

  	#atribute = params.keys[0]

  	#p params[atribute.to_sym]

  	#party.send atribute.to_sym, params[atribute.to_sym]

  	redirect '/'
end

get '/:id/delete' do

	parties.delete_if do |party|
		party.id == params[:id].to_i
	end
	redirect '/'
end

