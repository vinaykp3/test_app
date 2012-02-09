require 'spec_helper'

describe "pages/home.html.erb" do
  it "should render the home page elements" do
    render
    assert_select "h1", :content=>"Pages#home"
  end
end
