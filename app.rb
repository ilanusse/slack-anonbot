require 'sinatra'
require 'httparty'
require 'json'

SLACK_WEBHOOK = ENV['SLACK_WEBHOOK_URL']
CHANNEL_ID = ENV['CHANNEL_ID']
AVATAR = 'http://i463.photobucket.com/albums/qq354/coomberta/A_Real_Anon.png'

get '/anon' do
  return status(403) if params[:channel_id] != CHANNEL_ID
  postback(params[:text], params[:channel_id])
  status 200
end

def postback(message, channel)
  msg = message.gsub('@channel', '<!channel>').gsub('@here', '<!here>')
  HTTParty.post(SLACK_WEBHOOK,
                body: {
                  text: msg.to_s,
                  username: "Anon#{rand(1..40000)}",
                  channel: params[:channel_id],
                  icon_url: AVATAR,
                  link_names: 1
                }.to_json,
                headers: {'content-type' => 'application/json'})
end