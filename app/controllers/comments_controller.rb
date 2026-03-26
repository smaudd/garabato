class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[ edit update destroy ]

  def edit
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = Current.user if defined?(Current) && Current.respond_to?(:user)
    if @comment.save
      redirect_to @post, notice: "Comment was successfully created.", type: "success"
    else
      render "posts/show", status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: "Comment was successfully updated."
    else
      redirect_to post_path(@post, edit_comment_id: @comment.id), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    @comment.destroy!
    redirect_to @post, notice: "Comment was successfully destroyed."
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = @post.comments.find(params[:id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [ :post_id, :body ])
    end
end
