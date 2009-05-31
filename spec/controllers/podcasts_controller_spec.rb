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

describe PodcastsController, "handling GET /podcasts/new" do

  it "should be successful" do
    get :new
    response.should be_success
  end

  it "should render new template" do
    get :new
    response.should render_template('new')
  end

end

describe PodcastsController, "handling POST /podcasts with valid data" do

  before(:all) do
    @podcast_params = Factory.attributes_for(:podcast)
  end

  before do
    @podcast = mock_model(Podcast)
    Podcast.stub!(:new).and_return(@podcast)
    @podcast.stub!(:save).and_return(true)
  end

  it "should save the podcast" do
    @podcast.should_receive(:save).and_return(true)
    post :create, { :podcast => @podcast_params }
  end

  it "should redirect to /podcasts" do
    post :create, { :podcast => @podcast_params }
    response.should redirect_to(:action => 'index')
  end

end

describe PodcastsController, "handling POST /podcasts with invalid data" do

  before(:all) do
    @podcast_params = Factory.attributes_for(:podcast).merge(:title => nil)
  end

  before do
    @podcast = mock_model(Podcast)
    Podcast.stub!(:new).and_return(@podcast)
    @podcast.stub!(:save).and_return(false)
  end

  it "should be successful" do
    post :create, { :podcast => @podcast_params }
    response.should be_success
  end

  it "should render new template" do
    post :create, { :podcast => @podcast_params }
    response.should render_template('new')
  end

end
