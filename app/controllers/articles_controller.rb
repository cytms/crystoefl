# encoding: UTF-8
class ArticlesController < ApplicationController
  def index
  	#Article.create(:url => "http://www.scientificamerican.com/podcast/episode.cfm?id=fake-colon-spills-bacterial-secrets-13-05-30", :content => "When bacteria, like some strains of E. coli,enter the water supply they can threaten public health. To prevent such outbreaks, it’s useful to know how these microbes behave in their natural environments, rather than just in a petri dish. And one such environment is inside the human body.\n\nIn places without access to large sewage systems, bacteria-laden human waste passes into septic tanks. There it’s broken down before moving on into the groundwater. To study how a pathogenic strain of E. coli behaves in this entire system, researchers had to build a replica. Which includes an artificial human colon. The work is published in Applied and Environmental Microbiology. [Ian M. Marcus et al, Linking Microbial Community Structure to Function in Representative Simulated Systems]\n\nDid the counterfeit colon increase our E. coli comprehension? Well, the E. coli did behave differently than the same bacteria in isolation. They moved more slowly, and were more likely to form biofilms, slimy microbial communities that are hardier than individuals. Which means the bacteria could hang around in the groundwater longer. And that's a finding we don't want to flush away.", :web_category => "More Science#Biology", :advice_category => "1", :picture_url => "http://www.scientificamerican.com/assets/img/global_elements/60SS75x75.gif", :title => "History Test Article", :author => "Sophie Bushwick")
  	@articles = Article.all
  end

  def search
  end

  def feedback
  end
end
