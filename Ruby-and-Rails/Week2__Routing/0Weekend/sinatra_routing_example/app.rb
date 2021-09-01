require 'sinatra'

get '/' do
  "Home page, root route"
end

get '/albums' do
  "List of albums"
end

get '/albums/new' do
  "Page with the form for create a new album"
end

get '/albums/:id' do
  "Page with album info, specified with the id. The value of the id is #{params[:id]}"
end

post '/albums' do 
  "Add album to the collection.  Not accessible by URL typing"
end

get '/albums/:id/edit' do
  "Renders form for the album editing. The value of the id is #{params[:id]}"
end

patch '/album/:id' do
  "Updates existing album info. Again, not accessible by URL typing"
end

delete '/album/:id' do
  "Delete the album"
end

get '/custom_route' do
  "Whatever, if we really need it"
end
