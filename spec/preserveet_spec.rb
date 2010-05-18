require 'spec_helper'

describe Preserveet do
  before do
    @preserveet = Preserveet.new
  end
    
  describe "configuration" do
    it "loads from the default location" do
      @preserveet.config.should be_a(Hash)
    end

    it "loads from a given yaml" do
      @preserveet = Preserveet.new(File.expand_path('../fixtures/dummy.yml', __FILE__))
      @preserveet.config.should be_a(Hash)
      @preserveet.config['test'].should == "database"
    end
  end

  it "can connect to the database" do
    @preserveet = Preserveet.new(File.expand_path('../fixtures/test_database.yml', __FILE__))
    @preserveet.connect_to_database('test').should be_a(ActiveRecord::ConnectionAdapters::ConnectionPool)
    ActiveRecord::Base.remove_connection
  end
  
  describe "twitter" do
    before do
      @preserveet.connect_to_twitter
    end
    
    it "can connect to Twitter" do
      @preserveet.connect_to_twitter.class.should == Twitter::Base
    end
  
    it "can trigger Twitter to get tweets" do
      @preserveet.connect_to_twitter.tweets.should be_an(Array)
    end
  end
  
  it "outputs a friendly message when the instance is not connected to twitter" do
    @preserveet.tweets.should =~ /connect to Twitter/
  end
  
  it "has a callback to call on tweets before saving each tweet" do
  end
  
  it "can save tweets to a database" do
    
  end
end