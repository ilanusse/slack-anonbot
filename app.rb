require 'sinatra'
require 'httparty'
require 'json'

SLACK_WEBHOOK = ENV['SLACK_WEBHOOK_URL']
CHANNEL_NAME = ENV['CHANNEL_NAME']
 
get '/anon' do
  return status(403) if params[:channel_name] != CHANNEL_NAME
  postback(params[:text], params[:channel_id])
  status 200
end
 
def postback(message, channel)

  HTTParty.post(SLACK_WEBHOOK, 
                body: {
                  "text" => message.to_s,
                  "username" => "Anon#{rand(1..40000)}",
                  "channel" => params[:channel_id],
                  "icon_url" => "http://i463.photobucket.com/albums/qq354/coomberta/A_Real_Anon.png"
                }.to_json,
                headers: {'content-type' => 'application/json'})
end