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

describe PodcastsController, "handling GET /podcasts/:id/edit" do

  before(:all) do
    @podcast_id = 1
  end

  before do
    @podcast = mock_model(Podcast)
    Podcast.stub!(:find).and_return(@podcast)
  end

  it "should be successful" do
    get :edit, :id => @podcast_id
    response.should be_success
  end

  it "should render edit template" do
    get :edit, :id => @podcast_id
    response.should render_template('edit')
  end

  it "should find podcast by given id" do
    Podcast.should_receive(:find).with("#{@podcast_id}").and_return(@podcast)
    get :edit, :id => @podcast_id
  end

  it "should assign the found podcast for the view" do
    get :edit, :id => @podcast_id
    assigns[:podcast].should == @podcast
  end

end

describe PodcastsController, "handling PUT /podcasts/:id with valid data" do

  before(:all) do
    @podcast_id = 1
    @podcast_params = Factory.attributes_for(:podcast)
  end

  before do
    @podcast = mock_model(Podcast)
    Podcast.stub!(:find).and_return(@podcast)
    @podcast.stub!(:update_attributes).and_return(true)
  end

  it "should find podcast by given id" do
    Podcast.should_receive(:find).with("#{@podcast_id}").and_return(@podcast)
    put :update, :id => @podcast_id, :podcast => @podcast_params
  end

  it "should update podcast attributes" do
    @podcast.should_receive(:update_attributes).and_return(true)
    put :update, :id => @podcast_id, :podcast => @podcast_params
  end

  it "should redirect to /podcasts" do
    put :update, :id => @podcast_id, :podcast => @podcast_params
    response.should redirect_to(:action => 'index')
  end

end

describe PodcastsController, "handling PUT /podcasts/:id with invalid data" do

  before(:all) do
    @podcast_id = 1
    @podcast_params = Factory.attributes_for(:podcast, :title => nil)
  end

  before do
    @podcast = mock_model(Podcast)
    Podcast.stub!(:find).and_return(@podcast)
    @podcast.stub!(:update_attributes).and_return(false)
  end

  it "should find podcast by given id" do
    Podcast.should_receive(:find).with("#{@podcast_id}").and_return(@podcast)
    put :update, :id => @podcast_id, :podcast => @podcast_params
  end

  it "should be successful" do
    put :update, :id => @podcast_id, :podcast => @podcast_params
    response.should be_success
  end

  it "should render edit template" do
    put :update, :id => @podcast_id, :podcast => @podcast_params
    response.should render_template('edit')
  end

end

describe PodcastsController, "handling DELETE /podcasts/:id" do

  before do
    @podcast = mock_model(Podcast)
    @podcast.stub!(:id).and_return(42)
    Podcast.stub!(:destroy).with("#{@podcast.id}")
  end

  it "should destroy podcast" do
    Podcast.should_receive(:destroy).with("#{@podcast.id}")
    delete :destroy, { :id => @podcast.id }
  end

  it "should redirect to /podcasts" do
    delete :destroy, { :id => @podcast.id }
    response.should redirect_to(:action => 'index')
  end

end
