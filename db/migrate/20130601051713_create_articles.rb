class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :url
      t.text :content
      t.string :web_category
      t.string :advice_category
      t.string :picture_url
      t.string :title
      t.string :author
      t.string :summary
      t.string :feedback
      t.string :knn_category
      t.text :vocabulary
      t.timestamps
    end
  end
end
