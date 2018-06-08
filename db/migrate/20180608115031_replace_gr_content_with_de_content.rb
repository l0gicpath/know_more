class ReplaceGrContentWithDeContent < ActiveRecord::Migration[5.2]
  def up
    remove_column :articles, :gr_content
    add_column :articles, :de_content, :text, null: false, default: ""
  end

  def down
    add_column :articles, :gr_content, :text
    remove_column :articles, :de_content
  end
end
