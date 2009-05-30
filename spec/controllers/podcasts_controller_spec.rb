require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PodcastsController, "handling GET /podcasts" do

  before do
    @podcast = mock_model(Podcast)
    Podcast.stub!(:find).and_return([@podcast])
  end

  it "should be successful" do
    get :index
    response.should be_success
  end

  it "should render index template" do
    get :index
    response.should render_template('index')
  end

  it "should find all podcasts" do
    Podcast.should_receive(:find).with(:all).and_return([@podcast])
    get :index
  end

  it "should assign the found podcasts for the view" do
    get :index
    assigns[:podcasts].should == [@podcast]
  end

end
