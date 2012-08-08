#encoding: utf-8
class HomePagesController < ApplicationController
  respond_to :js, :html
  before_filter :authenticate, except: [:show]
  
  def show
    @new_releases = Product.new_releases.shuffle
    @opportunities = Product.opportunities.shuffle
    @future_releases = Product.future_releases.shuffle
    @trailer_movie = Product.random_trailer
  end
  
  def administrate
    
  end
  
  def manage
    @products = Product.all
    @what = params[:what]
    @featured = case params[:what]
    when "new_releases"
      Product.new_releases
    when "opportunities"
      Product.opportunities
    when "coming_up"
      Product.future_releases
    end
  end
  
  def add_featured
    @product = Product.find_by_id(params[:product_id])
    @what = params[:what]
    case params[:what]
    when "new_releases"
      @product.update_attributes(new_release: true)
    when "opportunities"
      @product.update_attributes(opportunity: true)
    when "coming_up"
      @product.update_attributes(future_release: true)
    end
    
    respond_with @product, @what
  end
  
  def remove_featured
    @product = Product.find_by_id(params[:product_id])
    case params[:what]
    when "new_releases"
      @product.update_attributes(new_release: false)
    when "opportunities"
      @product.update_attributes(opportunity: false)
    when "coming_up"
      @product.update_attributes(future_release: false)
    end
    
    respond_with @product
  end
end
