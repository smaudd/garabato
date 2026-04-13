class Api::V1::ChatVideosController < ApplicationController
  allow_unauthenticated_access

  def index
    @chat_videos = ChatVideo.order(created_at: :desc)
    render json: @chat_videos.map { |v| serialize_video(v, full: false) }
  end

  def show
    @chat_video = ChatVideo.includes(:chat_entries).find_by!(slug: params[:slug])
    render json: serialize_video(@chat_video, full: true)
  end

  private

    def serialize_video(video, full:)
      data = {
        slug:               video.slug,
        title:              video.title,
        model:              video.tts_model,
        voice:              video.voice,
        questionVoice:      video.question_voice,
        accentColor:        video.accent_color,
        background:         video.background_path,
        questionDisplayMs:  video.question_display_ms
      }

      if full
        data[:entries] = video.chat_entries.map { |e| serialize_entry(e) }
      end

      data
    end

    def serialize_entry(entry)
      {
        username:     entry.username,
        avatarEmoji:  entry.avatar_emoji,
        bubbleColor:  entry.bubble_color,
        question:     entry.question,
        questionVoice: entry.question_voice,
        answer:       entry.answer
      }
    end
end
