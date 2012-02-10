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

end
