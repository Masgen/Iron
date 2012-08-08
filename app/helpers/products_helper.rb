# encoding: utf-8

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

module ProductsHelper
  def trailer_helper(trailer_url)
    adjust_video return_video(trailer_url), "555", "335"
  end
  
  def genres_helper(product)
    genres = product.categories
    screen_name_collector = []
    genres.each do |genre|
      screen_name_collector << link_to(genre.screen_name, products_path(type: "movie", genre: genre.title, initial: "a"), class: "underlined")
    end
    screen_name_collector.join(", ").html_safe
  end
  
  def alphabet_helper(initial)
    alphabet_span = ""
    ALPHABET.each do |alp|
      alphabet_span << content_tag(:span, link_to(alp, products_path(initial: alp.downcase_extended, type: @type, genre: (@genre ? (@genre.is_a?(String) ? "blue" : @genre.title) : "")), style: "#{"color: orange;" if (alp.downcase == initial)}"), class: "letter")
    end
    alphabet_span.html_safe
  end
end
