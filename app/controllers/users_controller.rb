#encoding: utf-8
class UsersController < ApplicationController
  def edit
    @user = User.first
  end
  
  def update
    @user = User.first
    if @user.update_attributes(params[:user])
      redirect_to root_path
    else
      render "edit"
    end
  end
end
