require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PodcastsController do
  describe "handling GET /podcasts" do

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

  describe "handling GET /podcasts/:id" do

    before(:all) do
      @podcast_id = 42
    end

    before do
      @podcast = mock_model(Podcast)
      Podcast.stub!(:find).and_return(@podcast)
    end

    it "should be successful" do
      get :show, :id => @podcast_id
      response.should be_success
    end

    it "should render show template" do
      get :show, :id => @podcast_id
      response.should render_template('show')
    end

    it "should find podcast by given id" do
      Podcast.should_receive(:find).with("#{@podcast_id}").and_return(@podcast)
      get :show, :id => @podcast_id
    end

    it "should assign the found podcast for the view" do
      get :show, :id => @podcast_id
      assigns[:podcast].should == @podcast
    end

  end

  describe "handling GET /podcasts/new" do

    describe "as admin" do

      before do
        controller.stub!(:admin?).and_return(true)
      end

      it "should be successful" do
        get :new
        response.should be_success
      end

      it "should render new template" do
        get :new
        response.should render_template('new')
      end

    end

    describe "unauthorized" do

      before do
        controller.stub!(:admin?).and_return(false)
      end

      it "should not be successful" do
        get :new
        response.should_not be_success
      end

      it "should render access_restricted notification" do
        get :new
        response.should render_template('public/access_restricted.html')
      end

    end

  end

  describe "handling POST /podcasts" do

    describe "as admin" do

      before do
        controller.stub!(:admin?).and_return(true)
        @podcast = mock_model(Podcast)
        Podcast.stub!(:new).and_return(@podcast)
      end

      describe "with valid data" do

        before(:all) do
          @podcast_params = Factory.attributes_for(:podcast)
        end

        before do
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

      describe "with invalid data" do

        before(:all) do
          @podcast_params = Factory.attributes_for(:podcast, :title => nil)
        end

        before do
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

    end

    describe "unauthorized" do

      before(:all) do
        @podcast_params = Factory.attributes_for(:podcast)
      end

      before do
        controller.stub!(:admin?).and_return(false)
      end

      it "should not be successful" do
        post :create, { :podcast => @podcast_params }
        response.should_not be_success
      end

      it "should render access_restricted notification" do
        post :create, { :podcast => @podcast_params }
        response.should render_template('public/access_restricted.html')
      end

    end

  end

  describe "handling GET /podcasts/:id/edit" do

    before(:all) do
      @podcast_id = 1
    end

    describe "as admin" do

      before do
        controller.stub!(:admin?).and_return(true)
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

    describe "unauthorized" do

      before do
        controller.stub!(:admin?).and_return(false)
      end

      it "should not be successful" do
        get :edit, :id => @podcast_id
        response.should_not be_success
      end

      it "should render access_restricted notification" do
        get :edit, :id => @podcast_id
        response.should render_template('public/access_restricted.html')
      end

    end

  end

  describe "handling PUT /podcasts/:id" do

    before(:all) do
      @podcast_id = 1
    end

    describe "as admin" do

      before do
        controller.stub!(:admin?).and_return(true)
        @podcast = mock_model(Podcast)
        Podcast.stub!(:find).and_return(@podcast)
      end

      describe "with valid data" do

        before(:all) do
          @podcast_params = Factory.attributes_for(:podcast)
        end

        before do
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

      describe "with invalid data" do

        before(:all) do
          @podcast_params = Factory.attributes_for(:podcast, :title => nil)
        end

        before do
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

    end

    describe "unauthorized" do

      before(:all) do
        @podcast_params = Factory.attributes_for(:podcast)
      end

      before do
        controller.stub!(:admin?).and_return(false)
      end

      it "should not be successful" do
        put :update, :id => @podcast_id, :podcast => @podcast_params
        response.should_not be_success
      end

      it "should render access_restricted notification" do
        put :update, :id => @podcast_id, :podcast => @podcast_params
        response.should render_template('public/access_restricted.html')
      end

    end

  end

  describe "handling DELETE /podcasts/:id" do

    before(:all) do
      @podcast_id = 1
    end

    describe "as admin" do

      before do
        controller.stub!(:admin?).and_return(true)
        Podcast.stub!(:destroy).with("#{@podcast_id}")
      end

      it "should destroy podcast" do
        Podcast.should_receive(:destroy).with("#{@podcast_id}")
        delete :destroy, { :id => @podcast_id }
      end

      it "should redirect to /podcasts" do
        delete :destroy, { :id => @podcast_id }
        response.should redirect_to(:action => 'index')
      end

    end

    describe "unauthorized" do

      before do
        controller.stub!(:admin?).and_return(false)
      end

      it "should not be successful" do
        delete :destroy, { :id => @podcast_id }
        response.should_not be_success
      end

      it "should render access_restricted notification" do
        delete :destroy, { :id => @podcast_id }
        response.should render_template('public/access_restricted.html')
      end

    end

  end

end