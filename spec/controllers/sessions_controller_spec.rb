require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    describe "signin failure" do
      before(:each) do
        @attr={:email=>"example@example.com",:password=>"invalid"}
      end

      it "should render the signin page" do
        post :create, :session => @attr
        response.should render_template('new')
      end
    end

    describe "sign in success" do
      before(:each) do
        @user=Factory(:user)
        @attr={:email=>@user.email,:password=>@user.password}
      end

      it "should sign in the user" do
        post :create, :session=>@attr
        controller.current_user.should == @user
      end
    end

    describe "Destroy session" do
      it "should sign out a user" do
        test_sign_in(Factory(:user))
        delete :destroy
        controller.should_not be_signed_in
        response.should redirect_to(root_path)
      end
    end
  end

end
