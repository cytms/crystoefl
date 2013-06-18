# encoding: UTF-8
class ArticlesController < ApplicationController
  require 'json'
  #require 'kaminari'
  def index
    @articles = Article.page(params[:page]).per(100)
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
  	File.foreach('public/articles/Result.txt') do |line|
      file, category = line.split(' ')
      folder, tmp = file.split('_')
      File.foreach("public/articles/#{folder}/#{file}") do |content|
        json_file = JSON.parse(content)
        Article.create(:url => json_file["url"], :content => json_file["content"], :web_category => json_file["web_category"], :advice_category => json_file["advice_category"], :picture_url => json_file["picture_url"], :title => json_file["title"], :author => json_file["author"], :knn_category => category)
      end
    end
  	redirect_to '/'
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
