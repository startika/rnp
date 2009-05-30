require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Podcast do

  it "should validate presence of title" do
    podcast = Factory.build(:podcast, :title => "")
    podcast.should_not be_valid

    podcast = Factory.build(:podcast, :title => nil)
    podcast.should_not be_valid
  end

  it "should validate presence of asset_link" do
    podcast = Factory.build(:podcast, :asset_link => "")
    podcast.should_not be_valid

    podcast = Factory.build(:podcast, :asset_link => nil)
    podcast.should_not be_valid
  end

end
