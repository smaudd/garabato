class CreateChatVideos < ActiveRecord::Migration[8.1]
  def change
    create_table :chat_videos do |t|
      t.string  :slug,             null: false
      t.string  :title,            null: false
      t.string  :accent_color,     default: "#5865F2"
      t.integer :title_duration_ms, default: 3000

      t.timestamps
    end

    add_index :chat_videos, :slug, unique: true
  end
end
