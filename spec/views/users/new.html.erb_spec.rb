require 'spec_helper'

describe "users/new.html.erb" do

  before(:each) do
    assign(:user,stub_model(User, :name=>"name",
                      :email=>"user@example.com",:password=>"foobar",:password_confirmation=>"foobar").as_new_record)
  end

  it "should should contain the respective fields" do
    render
    assert_select "form", :action=>users_path, :method => "post" do
      assert_select "input#user_name", :name=>"user[name]"
      assert_select "input#user_email", :email => "user[email]"
      assert_select "input#user_password", :password => "user[password]"
      assert_select "input#user_password_confirmation", :password_confirmation=>"user[password_confirmation]"
      assert_select "input#user_password_confirmation", :password_confirmation=>"user[password_confirmation]"
    end
  end

end
