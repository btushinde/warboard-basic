# warboard.rb
require 'sinatra'
require 'pusher'
require 'json'
require 'httparty'
require 'github_api'
require 'pp'

Pusher.app_id = '28242'
Pusher.key = '1d429354391310d97281'
Pusher.secret = '7679f66095f826841f45'


get '/' do

	github = Github.new 
	erb :index, :layout => :index
	#haml :index
end


post '/git', :provides => :json do
	push = JSON.parse(params[:payload])
  Pusher['test_channel'].trigger('notification', push)
end

post '/payload' do
  push = JSON.parse(request.body.read)
  Pusher['test_channel'].trigger('notification', push)
end


get '/show' do
	pp Partay.post('http://localhost:9292/git', {})

end


get '/ping/:id' do

	id = params[:id]

# GitHub payload template
# {
#   :before     => before,
#   :after      => after,
#   :ref        => ref,
#   :commits    => [{
#     :id        => commit.id,
#     :message   => commit.message,
#     :timestamp => commit.committed_date.xmlschema,
#     :url       => commit_url,
#     :added     => array_of_added_paths,
#     :removed   => array_of_removed_paths,
#     :modified  => array_of_modified_paths,
#     :author    => {
#       :name  => commit.author.name,
#       :email => commit.author.email
#     }
#   }],
#   :repository => {
#     :name        => repository.name,
#     :url         => repo_url,
#     :pledgie     => repository.pledgie.id,
#     :description => repository.description,
#     :homepage    => repository.homepage,
#     :watchers    => repository.watchers.size,
#     :forks       => repository.forks.size,
#     :private     => repository.private?,
#     :owner => {
#       :name  => repository.owner.login,
#       :email => repository.owner.email
#     }
#   }
# }




	data = {'message' => 'Update recieved!', 'id' => id, 'text' => 'text here'}
	Pusher['test_channel'].trigger('notification', data)
end

get '/:file' do
	file = params[:file]
  	File.read(File.join('public',file ))
end







