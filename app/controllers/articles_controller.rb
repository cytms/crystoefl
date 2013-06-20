# encoding: UTF-8
class ArticlesController < ApplicationController
  require 'json'
  require 'stemmify'
  require 'open-uri'
  #require 'nokogiri'
  #require 'kaminari'
  def index
    if params[:category].nil?
      @articles = Article.page(params[:page]).per(100)
    else
      @articles = Article.where(:knn_category => params[:category]).page(params[:page]).per(100)
    end
    #@limit_page_num = Article.limit(100).count

    @array = []
    File.foreach("public/word_list.txt") do |line|
      @array.push(line.strip.stem)
      # puts @array.last
    end



    respond_to do |format|
      #if params[:category]!=nil and (params[:page]=="1" or params[:page]==nil)
      if params[:page].nil? and params[:category].nil?
        format.html
      else
        format.html{render :layout => false}
      end
      format.js
      format.json
    end
  end

  def get_datas
  	puts "get_datas..."

    # read vocabulary
    @dictionary = []
    File.foreach("public/word_list.txt") do |line|
      @dictionary.push(line.strip.stem)
      puts line
    end

    counter = 0 # for testing only
    hash = Hash.new
    
    File.foreach('public/Result.txt') do |line|
      file, category = line.split(' ')
      hash[file] = category
    end

    file_ary = hash.keys.sample(hash.length)

    file_ary.each do |file_name|
      File.foreach("public/articles/#{file_name}") do |content|
        json_file = JSON.parse(content)
        article = json_file["content"]

        @vocab_hash = Hash.new
        
        article.split(" ").each do |term|
          stem_term = term.stem
          if @dictionary.include?(stem_term)
            @vocab_hash[term] = stem_term
          end
          #@dictionary.each do |dic_term|
          #  if term.match(dic_term)
          #    @vocab_hash[term] = dic_term
          #  end
          #end
        end
        #puts @vocab_hash
        @vocab_with_translate = Hash.new

        @vocab_hash.each_key do |key|
          key = key.to_s.downcase
          @link = "http://tw.dictionary.yahoo.com/dictionary?p=#{key}"
          #doc = Nokogiri::HTML(open(@link))
          @translate = Nokogiri::HTML(open(@link)).css('li.explanation_pos_wrapper')
          p @translate
          @vocab_with_translate[key] = @translate.to_xml # .text could be eliminated 
        end

        Article.create(:url => json_file["url"], :content => json_file["content"], :web_category => json_file["web_category"], :advice_category => json_file["advice_category"], :picture_url => json_file["picture_url"], :title => json_file["title"], :author => json_file["author"], :knn_category => hash[file_name], :vocabulary => @vocab_with_translate.to_json, :summary => json_file["summary"])
      end
      puts counter
      counter = counter + 1
      if counter > 0 
        break
      end


    end
  	# redirect_to '/'
  end

  def search
    @q = params["q"]
  	@articles = Article.where("title LIKE '%#{params["q"]}%'").page(params[:page]).per(10)
    puts "finished"
  end

  def feedback
  end

  def select
    #
  end
end
