class AddUserRefToArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :user_id, :integer
    add_reference :articles, :user, foreign_key: true
  end
end
