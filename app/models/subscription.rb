class Subscription < ActiveRecord::Base
  attr_accessible :email
  
  default_scope -> { order("subscriptions.created_at DESC") }
  
  validates_format_of :email, with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\Z/
  validates_uniqueness_of :email
end
