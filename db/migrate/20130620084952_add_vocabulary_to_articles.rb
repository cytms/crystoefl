class AddVocabularyToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :vocabulary, :text
  end
end
