require 'spec_helper'

describe Preserveet do
  before do
    @preserveet = Preserveet.new
    @preserveet.connect_to_twitter
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
  
  it "can connect to Twitter" do
    @preserveet.connect_to_twitter.class.should == Twitter::Base
  end
  
  it "can trigger Twitter to get tweets" do
    @preserveet.tweets.should be_an(Array)
  end
  
  it "has a callback to call on tweets before saving each tweet" do
  end
  
  it "can save tweets to a database" do
    
  end
end