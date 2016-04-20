require 'sinatra'
require 'httparty'
require 'json'

get '/anon' do
  {
    "text" => params[:text].to_s,
    "username" => "Anon#{rand(1..40000)}",
    "channel" => params[:channel_id],
    "icon_url" => "http://i463.photobucket.com/albums/qq354/coomberta/A_Real_Anon.png"
  }.to_json
end