class AddFieldsToPosts < ActiveRecord::Migration[8.1]
  def change
    add_reference :posts, :company, null: true, foreign_key: true
    add_reference :posts, :category, null: true, foreign_key: true
    add_column :posts, :body, :text
    add_column :posts, :starts_at, :datetime
    add_column :posts, :ends_at, :datetime
  end
end
