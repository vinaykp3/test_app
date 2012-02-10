require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @attr=Factory(:user)
    end

    it "should response with content" do
      #ur=User.create!(@attr)
      get :show, :id=>@attr
      assigns(:user).should eq(@attr)
    end
  end

  describe "POST 'create'" do
    describe "signup failure" do
      before(:each) do
        @attr= {:name=>"",:email=>"",:password=>"",:password_confirmation=>""}
      end

      it "should not create an user" do
        lambda do
          post :create, :user=>@attr
        end.should_not change(User, :count)
      end
      it "should redirect to signup page" do
        post :create, :user =>@attr
        response.should render_template('new')
      end
    end

    describe "signup success" do
      before(:each) do
        @attr ={:name=>"Name",:email=>"user@example.com",:password=>"foobar",:password_confirmation=>"foobar"}
      end

      it "should create an user" do
        lambda do
          post :create, :user=>@attr
        end.should change(User,:count).by(1)
      end

      it "should redirect to user page" do
        post :create, :user=>@attr
        response.should redirect_to(user_path(assigns(:user)))
      end
    end
  end

end
