# encoding: utf-8

require "net/http"
require "uri"
require "oembed"

class String
  def downcase_extended
    case self
    when "Ö"
      return "ö"
    when "Ş"
      return "ş"
    when "Ç"
      return "ç"
    when "İ"
      return "i"
    when "Ü"
      return "ü"
    else
      self.downcase
    end
  end
end

class Product < ActiveRecord::Base
  before_save :fill_initial
  before_update :fill_initial
  attr_accessible :title, :blue, :product_type, :initial, :poster, :summary, :normal_price, :discount_price, :year, :director, :duration, :language, :new_release, :actors, :opportunity, :future_release, :remote_poster_url, :trailer_url, :category_ids, :imdb_score
  
  has_and_belongs_to_many :categories
  
  default_scope -> { order("products.title ASC") }
  scope :by_type, ->(t) { where("products.product_type = ?", t)}
  scope :by_initial, ->(i) { where(initial: i)}
  scope :by_genre, ->(g) { joins(:categories).where("categories.title = ? ", g)}
  scope :new_releases, -> { where(new_release: true) }
  scope :opportunities, -> { where(opportunity: true) }
  scope :future_releases, -> { where(future_release: true) }
  scope :new_movie_with_trailer, -> { where(new_release: true).where(product_type: "movie").where("products.trailer_url != ''")}
  scope :blue, -> { where(blue: true) }
    
  define_index do
    indexes title
    indexes summary
    indexes actors
    indexes director
  end
  
  mount_uploader :poster, PosterUploader
  
  def self.random_trailer
    Product.new_movie_with_trailer.sample
  end
  
  def self.fetch_info(tmdb_url)
    info = Hash.new
    Tmdb.api_key = API_KEY[:tmdb]
    Tmdb.default_language = "tr"
    
    id = /\/movie\/(\w+)/.match(tmdb_url)
    if id.blank?
      return false
    else
      id = id[1].to_i
    end
    
    retries = 3
    movie = Hash.new
    begin
      movie[:tr] = TmdbMovie.find(id: id, language: "tr")
      movie[:en] = TmdbMovie.find(id: id, language: "en")
    rescue
      retries -= 1
      if retries > 0
        retry
      else
        return false
      end
    end
    
    if movie[:en].blank?
      return false
    end
    
    if movie[:tr].translated
      info[:summary] = movie[:tr].overview
    end
    info[:name] = movie[:en].name
    if (directors = movie[:en].cast.select {|cast| cast.department == "Directing"}) && !directors.blank?
      info[:directors] = directors.map(&:name) 
    end
    if (actors = movie[:en].cast.select {|cast| cast.department == "Actors"}) && !actors.blank?
      info[:actors] = actors.map(&:name).first(5) 
    end
    info[:duration] = movie[:en].runtime
    info[:year] = /(\d+)-/.match(movie[:en].released)[1].to_i
    info[:poster_url] = movie[:en].posters.select {|poster| (poster.width) > 225 && (poster.height > 330)}.first.url
    info[:trailer_url] = movie[:en].trailer if /youtube/.match(movie[:en].trailer)
    retries = 3
    begin
      OEmbed::Providers::Youtube.get(info[:trailer_url])
    rescue
      retries -= 1
      if retries > 0
        retry
      else
        info[:trailer_url] = nil
      end
    end
    if (genres = movie[:en].genres.map(&:name)) && !genres.blank?
      info[:categories] = Category.to_id(genres)
    end
    
    retries = 3
    begin
      imdb_scrape = Net::HTTP.get(URI.parse("http://www.imdb.com/title/#{movie[:en].imdb_id}/"))
    rescue
      retries -= 1
      if retries > 0
        retry
      else
        imdb_scrape = nil
      end
    end
    
    if imdb_scrape
      info[:imdb_score] = /<div class="star-box-giga-star">\n?(\d+{1,2}\.\d)/.match(imdb_scrape)[1]
    end
    
    info
  end
  
  protected
  
  def fill_initial
    self.initial = self.title[0]
  end
end
