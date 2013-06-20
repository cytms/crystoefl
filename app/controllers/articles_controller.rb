# encoding: UTF-8
class ArticlesController < ApplicationController
  require 'json'
  require 'stemmify'
  require 'open-uri'
  #require 'kaminari'
  def index
    @articles = Article.page(params[:page]).per(100)

    @array = []
    File.foreach("public/word_list.txt") do |line|
      @array.push(line.strip.stem)
      # puts @array.last
    end



    respond_to do |format|
      if params[:page]=="1" or params[:page]==nil
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
      puts @dictionary.last
    end

    counter = 0 # for testing only

  	File.foreach('public/articles/Result.txt') do |line|
      file, category = line.split(' ')
      folder, tmp = file.split('_')
      File.foreach("public/articles/#{folder}/#{file}") do |content|
        json_file = JSON.parse(content)

        article = json_file["content"]
        @vocab_hash = {}
        article.split(" ").each do |term|
          stem_term = term.stem
          if @dictionary.include?(stem_term)
            @vocab_hash[term] = stem_term
          end
        end
        
        puts @vocab_hash

        @vocab_with_translate = {}

        @vocab_hash.each_key{|key|
          @link = "http://tw.dictionary.yahoo.com/dictionary?p=" + key.to_s

          doc = Nokogiri::HTML(open(@link))
          @translate = doc.css('li.explanation_pos_wrapper')

          @vocab_with_translate[key] = @translate.to_xml # .text could be eliminated 
          
        }

        

        Article.create(:url => json_file["url"], :content => json_file["content"], :web_category => json_file["web_category"], :advice_category => json_file["advice_category"], :picture_url => json_file["picture_url"], :title => json_file["title"], :author => json_file["author"], :knn_category => category, :vocabulary => @vocab_with_translate.to_json)
      end


      counter = counter + 1 # for testing only
      if counter > 6
          break
      end
      # stemming 
      # match 
      # translate
      # db: AddColumn text

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
