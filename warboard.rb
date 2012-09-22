# warboard.rb
require 'sinatra'
require 'pusher'
require 'json'
require 'httparty'

Pusher.app_id = '28242'
Pusher.key = '1d429354391310d97281'
Pusher.secret = '7679f66095f826841f45'


get '/' do
	erb :index, :layout => :index
	#haml :index
end

get '/party' do 
	response = HTTParty.get('http://twitter.com/statuses/public_timeline.json')
	#puts response.body, response.code, response.message, response.headers.inspect
	for_json = JSON.parse(response);
end


post '/git/:data', :provides => :json do
	pass unless request.accept? 'application/json'

	jdata = params[:data]
	for_json = JSON.parse(jdata)
	Pusher['test_channel'].trigger('notification', for_json)
end



get '/ping/:id' do

	id = params[:id]

	data = {'message' => 'Update recieved!', 'id' => id}
	Pusher['test_channel'].trigger('notification', data)
end

get '/:file' do
	file = params[:file]
  	File.read(File.join('public',file ))
end






