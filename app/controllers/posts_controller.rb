class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[ show index ]
  before_action :set_post, only: %i[ show ]

  def index
    @posts = Post.includes(:company, :category, :locations, :tags).order(created_at: :desc)
  end

  def show
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end
end
