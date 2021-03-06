class Article < ActiveRecord::Base
  attr_accessible :url, :content, :web_category, :advice_category, :picture_url, :title, :author, :knn_category, :summary, :feedback, :vocabulary
  def v
    h = Hash.new
    JSON.parse(self.vocabulary).each do |k, v|
      h[k] = Nokogiri::HTML(%{#{v}}).text
    end
    return h
  end
  def icon
  	case self.knn_category
  	 when "1"
  	 	return "icon-time"
  	 when "2"
  	 	return "icon-leaf" #globe
  	 when "3"
  	 	return "icon-cog"
  	 when "4"
  	 	return "icon-globe" #beaker
  	 when "5"
  	 	return "icon-group"
  	 when "6"
  	 	return "icon-pencil"
  	 else
  	 	return "icon-question-sign"
  	 end
  end
end
