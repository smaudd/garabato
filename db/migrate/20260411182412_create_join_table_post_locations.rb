class CreateJoinTablePostLocations < ActiveRecord::Migration[8.1]
  def change
    create_join_table :posts, :locations do |t|
      t.index [:post_id, :location_id]
      t.index [:location_id, :post_id]
    end
  end
end
