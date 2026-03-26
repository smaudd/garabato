class LikesController < ApplicationController
  before_action :set_likeable

  def create
    like = @likeable.likes.find_or_initialize_by(user: Current.user)
    like.value = like_params[:value]
    if like.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(helpers.dom_id(@likeable), partial: partial_path, locals: { @likeable.model_name.element.to_sym => @likeable }) }
        format.html { redirect_back fallback_location: root_path, notice: "Voto registrado." }
      end
    else
      redirect_back fallback_location: root_path, alert: "No se pudo registrar el voto."
    end
  end

  def destroy
    like = @likeable.likes.find_by(user: Current.user)
    like&.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(helpers.dom_id(@likeable), partial: partial_path, locals: { @likeable.model_name.element.to_sym => @likeable }) }
      format.html { redirect_back fallback_location: root_path, notice: "Voto eliminado." }
    end
  end

  private
    def set_likeable
      if params[:comment_id]
        @likeable = Comment.find(params[:comment_id])
      elsif params[:post_id]
        @likeable = Post.find(params[:post_id])
      else
        head :bad_request
      end
    end

    def like_params
      params.require(:like).permit(:value)
    end

    def partial_path
      if @likeable.is_a?(Post)
        "posts/post"
      else
        "comments/comment"
      end
    end
end
