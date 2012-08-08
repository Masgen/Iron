class Category < ActiveRecord::Base
  attr_accessible :title, :screen_name
  
  has_and_belongs_to_many :products
  
  def self.to_id(categories)
    begin
      categories.map {|elem| GENRES_HASH[elem]}.compact.map {|title| Category.find_by_title(title).id }.uniq
    rescue
      return false
    end
  end
end
