#encoding: utf-8
class SessionsController < ApplicationController
  before_filter :authenticate, except: [:create]
  
  def create
    if user = User.authenticate(params[:nickname],params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Başarıyla çıkış yaptınız."
    else
      render "new"
    end
  end
  
  def destroy
    reset_session
    redirect_to root_path, notice: "Başarıyla çıkış yaptınız."
  end
end
