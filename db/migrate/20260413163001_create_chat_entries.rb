class CreateChatEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :chat_entries do |t|
      t.references :chat_video,        null: false, foreign_key: true
      t.integer    :position,          null: false, default: 0
      t.string     :username,          null: false
      t.string     :avatar_emoji
      t.string     :bubble_color
      t.text       :question,          null: false
      t.integer    :question_duration_ms, default: 0
      t.text       :answer,            null: false
      t.integer    :answer_duration_ms,   default: 0

      t.timestamps
    end

    add_index :chat_entries, [ :chat_video_id, :position ]
  end
end
