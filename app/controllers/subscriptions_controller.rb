# encoding: utf-8
class SubscriptionsController < ApplicationController
  before_filter :authenticate, only: [:show]
  
  def show
    @subscriptions = Subscription.all
  end
  
  def create
    @subscription = Subscription.new
    @subscription.email = params[:email]
    if @subscription.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
end
