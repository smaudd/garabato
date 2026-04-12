class Admin::LocationsController < Admin::BaseController
  before_action :set_company
  before_action :set_location, only: %i[ show edit update destroy ]

  def index
    @locations = @company.locations.order(:name)
  end

  def show
  end

  def new
    @location = @company.locations.build
  end

  def edit
  end

  def create
    @location = @company.locations.build(location_params)

    if @location.save
      redirect_to admin_company_location_path(@company, @location), notice: t("admin.notices.location.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @location.update(location_params)
      redirect_to admin_company_location_path(@company, @location), notice: t("admin.notices.location.updated"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @location.destroy!
    redirect_to admin_company_locations_path(@company), notice: t("admin.notices.location.destroyed"), status: :see_other
  end

  private

    def set_company
      @company = Company.find(params[:company_id])
    end

    def set_location
      @location = @company.locations.find(params[:id])
    end

    def location_params
      params.expect(location: [ :name, :address, :phone ])
    end
end
