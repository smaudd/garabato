class Admin::ChatVideosController < Admin::BaseController
  before_action :set_chat_video, only: %i[show edit update destroy]

  def index
    @chat_videos = ChatVideo.order(created_at: :desc)
  end

  def show
  end

  def new
    @chat_video = ChatVideo.new
    @chat_video.chat_entries.build
  end

  def edit
  end

  def create
    @chat_video = ChatVideo.new(chat_video_params)

    if @chat_video.save
      redirect_to admin_chat_video_path(@chat_video), notice: t("admin.chat_videos.notices.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @chat_video.update(chat_video_params)
      redirect_to admin_chat_video_path(@chat_video), notice: t("admin.chat_videos.notices.updated"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @chat_video.destroy!
    redirect_to admin_chat_videos_path, notice: t("admin.chat_videos.notices.destroyed"), status: :see_other
  end

  private

    def set_chat_video
      @chat_video = ChatVideo.find(params[:id])
    end

    def chat_video_params
      params.require(:chat_video).permit(
        :slug, :title, :accent_color, :tts_model, :voice, :question_voice,
        :question_display_ms, :background, :rendered_video,
        chat_entries_attributes: [
          :id, :username, :avatar_emoji, :bubble_color,
          :question, :question_voice,
          :answer, :background,
          :_destroy
        ]
      )
    end
end
