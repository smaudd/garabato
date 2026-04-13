class SimplifyChatVideoSchema < ActiveRecord::Migration[8.1]
  def change
    # Drop composite index that includes :position before removing the column
    remove_index :chat_entries, name: "index_chat_entries_on_chat_video_id_and_position"

    # ── chat_videos ──────────────────────────────────────────────────────────
    remove_column :chat_videos, :title_duration_ms, :integer

    add_column :chat_videos, :tts_model,          :string,  default: "speaches-ai/Kokoro-82M-v1.0-ONNX", null: false
    add_column :chat_videos, :voice,              :string,  default: "em_santa",                          null: false
    add_column :chat_videos, :question_voice,     :string,  default: "ef_dora",                           null: false
    add_column :chat_videos, :question_display_ms,:integer, default: 2500,                                null: false
    add_column :chat_videos, :background_path,    :string

    # ── chat_entries ─────────────────────────────────────────────────────────
    remove_column :chat_entries, :position,             :integer
    remove_column :chat_entries, :question_duration_ms, :integer
    remove_column :chat_entries, :answer_duration_ms,   :integer

    add_column :chat_entries, :question_voice, :string
  end
end
