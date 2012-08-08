#encoding: utf-8
module HomePagesHelper
  def trailer_helper(trailer_url)
    adjust_video return_video(trailer_url), "510", "305"
  end
  
  def what_heading_helper(what)
    case what
    when "opportunities"
      "Fırsatlar"
    when "new_releases"
      "Yeni Çıkanlar"
    when "coming_up"
      "Gelecek Vizyon"
    end
  end
  
  def featured_li_helper(product,what)
    html = ""
    html << ("<li id='product_#{product.id}'>")
    html << content_tag(:span, link_to(product.title, product_path(product.id)), class: "title")
    html << " - "
    html << link_to("Listeden kaldır", remove_featured_home_page_path(product_id: product.id,what: what), method: :post, remote: true, class: "underlined")
    html << "</li>"
    html.html_safe
  end
end
