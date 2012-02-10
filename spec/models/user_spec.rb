require 'spec_helper'

describe User do

  before (:each) do
    @attr={:name=>"Person Name", :email=>"user@example.com",:password=>"foobar",:password_confirmation=>"foobar"}
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

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
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

  describe "password validation" do
    it "should require a password" do
      empty_pwd=User.new(@attr.merge(:password=>"",:password_confirmation=>""))
      empty_pwd.should_not be_valid
    end

    it "should accept confirm pwd same as password" do
      incorect_pwd=User.new(@attr.merge(:password_confirmation=>"invalild"))
      incorect_pwd.should_not be_valid
    end

    it "should reject short password" do
      shrt_pwd="a"*5
      shrt_pwd_usr=User.new(@attr.merge(:password=>shrt_pwd,:password_confirmation=>shrt_pwd))
      shrt_pwd_usr.should_not be_valid
    end

    it "should reject long password" do
      lng_pwd="a"*30
      lng_pwd_usr=User.new(@attr.merge(:password=>lng_pwd,:password_confirmation=>lng_pwd))
      lng_pwd_usr.should_not be_valid
    end
  end

  describe "password encryption" do
    before(:each) do
      @user=User.create!(@attr)
    end

    it "should have encrypted pwd attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should be true if it has matching pawd" do
      @user.has_password?(@attr[:password]).should be_true
    end
  end

  describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end

end
