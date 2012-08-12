#encoding: utf-8
class ProductsController < ApplicationController
  before_filter :authenticate, except: [:index, :search, :show]
  respond_to :js, :html
  
  def index
    # type filter
    @products = Product.by_type(params[:type])
    @type = params[:type]
    
    # initial filter
    unless params[:initial].blank?
      @products = @products.by_initial(params[:initial]) 
      @initial = params[:initial]
    end
    
    # genre filter
    unless params[:genre].blank?
      if params[:genre] == "blue"
        @products = @products.blue
        @genre = "Blue Ray"
      else
        @products = @products.by_genre(params[:genre])
        @genre = Category.find_by_title(params[:genre])
      end
    end

    # pagination
    @products = @products.paginate(page: params[:page], per_page: 18)
  end
  
  def search
    @search = params[:search].strip if params[:search]
    @search = "" unless params[:search]
    @results = Product.search(params[:search], :page => params[:page], :per_page => 5)
    
    respond_with @results
  end
  
  def show
    @product = Product.find_by_id(params[:id])
  end
  
  def new
    @type = params[:type]
    @product = Product.new
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to product_path(@product), notice: "Ürün başarıyla eklenmiştir."
    else
      render new_product_path
    end
  end
  
  def edit
    @type = params[:type]
    @product = Product.find_by_id(params[:id])
  end
  
  def update
    @product = Product.find_by_id(params[:id])
    
    if @product.update_attributes(params[:product])
      redirect_to product_path(@product), notice: "Ürün başarıyla güncellenmiştir."
    else
      render edit_product_path(@product)
    end
  end
  
  def destroy
    Product.find_by_id(params[:id]).destroy
    redirect_to root_path, notice: "Ürün başarıyla silinmiştir."
  end
  
  def fill
    @info = Product.fetch_info(params[:tmdb_url])
    
    respond_with @info
  end
end
