# warboard.rb
require 'sinatra'
require 'pusher'
require 'json'


get '/' do
	erb :index, :layout => :index
end


get '/ping/:id' do
	Pusher.app_id = '28242'
	Pusher.key = '1d429354391310d97281'
	Pusher.secret = '7679f66095f826841f45'

	id = params[:id]

	data = {'message' => 'Update recieved!', 'id' => id}
	Pusher['test_channel'].trigger('notification', data)
end

get '/:file' do
	file = params[:file]
  	File.read(File.join('public',file ))
end