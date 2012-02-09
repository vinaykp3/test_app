require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @attr={:name=>"Name", :email => "email@email.com"}
    end

    it "should response with content" do
      ur=User.create!(@attr)
      get :show, :id=>ur.id
      assigns(:show).should eq(ur)
    end
  end

end
