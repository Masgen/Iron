require "oembed"
module ApplicationHelper
  def cast_helper(cast, limit = nil)
    return "" if cast.blank?
    cast_collection = cast.scan(/\w[\w\s'-]*/)
    cast_collection = cast_collection.first(limit) if limit.is_a?(Fixnum)
    cast_html = []
    cast_collection.each do |cast|
      cast_html << link_to(cast, search_products_path(search: cast), class: "underlined")
    end
    cast_html.join(", ").html_safe
  end
  
  def return_video(url)
    begin
      if url =~ /youtube/
        OEmbed::Providers::Youtube.get(url)
      else
        false
      end
    rescue
      return false
    end 
  end
  
  def adjust_video(video,width,height)
    if video 
      width_adjusted = video.html.gsub(/width="\d+"/,"width=\"#{width}\"")
      height_adjusted = width_adjusted.gsub(/height="\d+"/,"height=\"#{height}\"")
      all_adjusted = height_adjusted.sub(/(?<=src=")(.+)(?=" frameborder="0" allowfullscreen>)/,'\1&wmode=opaque')
      all_adjusted
    else
      false
    end
  end
end
