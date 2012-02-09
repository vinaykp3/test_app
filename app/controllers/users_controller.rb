class UsersController < ApplicationController
  def new
    @title="Sign Up"
  end

  def show
    @user=User.find(params[:id])
    @title = "User Info"
  end
end
