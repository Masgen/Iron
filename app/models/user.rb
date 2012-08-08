require "digest/sha1"
class User < ActiveRecord::Base
  before_save   :create_hashed_password
  after_save  :clear_password
  
  attr_accessor   :password
  
  attr_accessible :nickname, :password, :title_alpha, :title_beta, :title_omega
  
  def self.hash_with_password(password="",salt="")
    Digest::SHA1.hexdigest("sdlasda345sd#{password},ad55ouasdww43#{salt}43w")
  end
  
  def self.make_salt
    Digest::SHA1.hexdigest("sdsdfdsf#{Time.now}asdasd#{Time.now}asdasd")
  end
  
  def self.authenticate(nickname,password)
    user = User.find_by_nickname(nickname)
    if user && user.password_match?(password)
      return user
    else
      return false
    end
  end
  
  def password_match?(password)
    self.hashed_password = User.hash_with_password(password,salt)
  end
  
  protected
  
  def create_hashed_password
    self.salt = User.make_salt if salt.blank?
    self.hashed_password = User.hash_with_password(password,salt)
  end
  
  def clear_password
    self.password = ""
  end
end
