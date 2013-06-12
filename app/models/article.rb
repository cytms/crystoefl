class Article < ActiveRecord::Base
  attr_accessible :url, :content, :web_category, :advice_category, :picture_url, :title, :author

  def icon
  	case self.advice_category
  	 when "1"
  	 	return "icon-time"
  	 when "2"
  	 	return "icon-leaf"
  	 when "3"
  	 	return "icon-beaker"
  	 when "4"
  	 	return "icon-globe"
  	 when "5"
  	 	return "icon-group"
  	 when "6"
  	 	return "icon-pencil"
  	 when "7"
  	 	return "icon-cog"
  	 else
  	 	return "icon-question-sign"
  	 end
  end
end
