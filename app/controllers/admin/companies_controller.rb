class Admin::CompaniesController < Admin::BaseController
  before_action :set_company, only: %i[ show edit update destroy locations_for_select ]

  def index
    @companies = Company.all.order(:name)
  end

  def show
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to admin_company_path(@company), notice: t("admin.notices.company.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @company.update(company_params)
      redirect_to admin_company_path(@company), notice: t("admin.notices.company.updated"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy!
    redirect_to admin_companies_path, notice: t("admin.notices.company.destroyed"), status: :see_other
  end

  def locations_for_select
    locations = @company.locations.order(:name).map { |l| { id: l.id, name: l.name } }
    render json: locations
  end

  private

    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.expect(company: [ :name, :description, :website ])
    end
end
