require "spec_helper"

describe "users/show.html.erb" do

  before(:each) do
    @attr=assign(:user,stub_model(User,:name=>"user",:email=>"user@example.com"))
  end

  it "should render the show page elements" do
    render
    assert_select "h1", :content=> @attr.name
  end

  it "should have profile image" do
    render
    assert_select "h1>img", :class=>"gravatar"
  end

end