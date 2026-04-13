class RestoreBackgroundAttachments < ActiveRecord::Migration[8.1]
  def change
    remove_column :chat_videos, :background_path, :string
  end
end
