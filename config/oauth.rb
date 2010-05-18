require 'pp'
require 'pathname'
dir = Pathname(__FILE__).dirname.expand_path
require "rubygems"
require "twitter"

config = YAML.load_file(File.expand_path('../config.yml', __FILE__))
oauth = Twitter::OAuth.new(config['twitter']['token'], config['twitter']['secret'])
puts config['twitter']['token']
rtoken = oauth.request_token.token
rsecret = oauth.request_token.secret

puts "> redirecting you to twitter to authorize..."
%x(open #{oauth.request_token.authorize_url})

print "> what was the PIN twitter provided you with? "
pin = gets.chomp

begin
  oauth.authorize_from_request(rtoken, rsecret, pin)
  puts "rtoken: #{rtoken}"
  puts "rsecret: #{rsecret}"
  puts "pin: #{pin}"
  twitter = Twitter::Base.new(oauth)
  twitter.user_timeline.each do |tweet|
    puts "#{tweet.user.screen_name}: #{tweet.text}"
  end
rescue OAuth::Unauthorized
  puts "> FAIL!"
end

