class Admin::DashboardController < Admin::BaseController
  def index
    @companies_count = Company.count
    @locations_count = Location.count
    @posts_count = Post.count
    @categories_count = Category.count
    @tags_count = Tag.count
    @recent_posts = Post.includes(:company, :category).order(created_at: :desc).limit(5)
  end
end
