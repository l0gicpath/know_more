class AddGermanContentToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :gr_content, :text
  end
end
