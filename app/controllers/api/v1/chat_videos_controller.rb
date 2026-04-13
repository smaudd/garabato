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
        slug:            video.slug,
        title:           video.title,
        accentColor:     video.accent_color,
        titleDurationMs: video.title_duration_ms,
        background:      attached_url(video.background),
        titleAudioFile:  attached_url(video.title_audio)
      }

      if full
        data[:entries] = video.chat_entries.map { |e| serialize_entry(e) }
      end

      data
    end

    def serialize_entry(entry)
      {
        username:            entry.username,
        avatarEmoji:         entry.avatar_emoji,
        bubbleColor:         entry.bubble_color,
        question:            entry.question,
        questionDurationMs:  entry.question_duration_ms,
        questionAudioFile:   attached_url(entry.question_audio),
        answer:              entry.answer,
        answerDurationMs:    entry.answer_duration_ms,
        answerAudioFile:     attached_url(entry.answer_audio),
        background:          attached_url(entry.background)
      }
    end

    def attached_url(attachment)
      return nil unless attachment.attached?
      rails_blob_url(attachment, only_path: false, host: request.base_url)
    end
end
