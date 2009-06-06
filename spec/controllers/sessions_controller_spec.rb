require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SessionsController, "handling GET /auth" do

  it "should be successful" do
    get :new
    response.should be_success
  end

  it "should use sessions layout" do
    get :new
    response.should use_layout 'sessions'
  end

  it "should render new template" do
    get :new
    response.should render_template('new')
  end

end

describe SessionsController, "handling POST /auth with valid access token" do

  before(:all) do
    APP_CONFIG[:access_token] = "access-token"
  end

  it "should store access token in session" do
    post :create, :access_token => "access-token"
    session[:access_token].should == "access-token"
  end

  it "should redrect to /podcasts" do
    post :create, :access_token => "access-token"
    response.should redirect_to podcasts_path
  end

end

describe SessionsController, "handling POST /auth with invalid access token" do

  before(:all) do
    APP_CONFIG[:access_token] = "access-token"
  end

  it "should be successful" do
    post :create, :access_token => "wrong-access-token"
    response.should be_success
  end

  it "should render new template" do
    post :create, :access_token => "wrong-access-token"
    response.should render_template 'new'
  end

  it "should set flash" do
    flash_now = mock('flash_now')
    flash.should_receive(:now).and_return(flash_now)
    flash_now.should_receive(:[]=).with(:error, anything())
    post :create, :access_token => "wrong-access-token"
  end

end
