require 'spec_helper'

describe User do

  before (:each) do
    @attr={:name=>"Person Name", :email=>"user@example.com"}
  end

  it "should create an user" do
    User.create!(@attr)
  end

  it "should require company name" do
    no_name=User.new(@attr.merge(:name=>""))
    no_name.should_not be_valid
  end

  it "should require email address" do
    no_email=User.new(@attr.merge(:email=>""))
    no_email.should_not be_valid
  end

  it "should reject long name" do
    long_name="a"*51
    long_name_user=User.new(@attr.merge(:name=>long_name))
    long_name_user.should_not be_valid
  end

  it "should reject invalid email address" do
    eaddr=%w[foo@foo foo@foo,com foo.com foo.exampl@org]
    eaddr.each do |addr|
      wrong_email_user=User.new(@attr.merge(:email=>addr))
      wrong_email_user.should_not be_valid
    end
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject duplicate email addr" do
    User.create!(@attr)
    duplicate_email=User.new(@attr)
    duplicate_email.should_not be_valid
  end

end
