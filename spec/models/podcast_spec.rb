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

  describe "performing operations requiring its number to be updated" do

    before do
      @last_podcast_number = 5

      Podcast.delete_all
      @last_podcast_number.times do |idx|
        Factory(:podcast, :title => "Podcast Numbered #{idx + 1}")
      end
    end

    it "should automatically set number" do
      podcast = Factory(:podcast)
      podcast.number.should == @last_podcast_number + 1
    end

    it "should set correct number if any other podcast has been removed before" do
      broken_podcast = Factory(:podcast)
      broken_podcast.destroy
      podcast = Factory(:podcast)
      podcast.number.should == @last_podcast_number + 1
    end

    it "should correct podcast numbers on delete" do
      podcast = Factory(:podcast)
      lambda {
        Podcast.find(:first, :offset => @last_podcast_number/2).destroy # remove in around a middle
        podcast.reload
      }.should change(podcast, :number).by(-1)
    end

  end
  
end
