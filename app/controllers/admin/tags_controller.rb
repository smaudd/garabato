class Admin::TagsController < Admin::BaseController
  before_action :set_tag, only: %i[ show edit update destroy ]

  def index
    @tags = Tag.order(:name)
  end

  def show
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to admin_tag_path(@tag), notice: "Tag was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to admin_tag_path(@tag), notice: "Tag was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy!
    redirect_to admin_tags_path, notice: "Tag was successfully destroyed.", status: :see_other
  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.expect(tag: [ :name ])
    end
end
