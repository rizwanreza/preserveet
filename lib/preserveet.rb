require File.expand_path('../../config/environment.rb', __FILE__)

class Preserveet
  def initialize(config_path = File.expand_path('../../config/config.yml', __FILE__))
    @config = YAML.load_file(config_path)
  end
  
  def config
    @config
  end

  def connect_to_database(environment)
    ActiveRecord::Base.establish_connection(config[environment])
  end

  def connect_to_twitter(email = config['twitter']['email'], password = config['twitter']['password'])
    httpauth = Twitter::HTTPAuth.new(config['twitter']['email'], config['twitter']['password'])
    @client = Twitter::Base.new(httpauth)
    
  end

  def tweets
    @client.user_timeline
  end

  def save
  end
end