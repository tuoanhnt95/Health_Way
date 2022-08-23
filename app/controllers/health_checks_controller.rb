class HealthChecksController < ApplicationController
  before_action :set_set_up, only: %i[show create edit update]

  def index
    @health_check = HealthCheck.all
  end

  def show
  end

  def new
    @health_check = HealthCheck.new
    @clinics = Clinic.all
    authorize @health_check
  end

  def create
    @health_check = HealthCheck.new(health_check_params)
    @health_check.user = current_user
    @health_check.set_up = @set_up
    authorize @health_check
    if @health_check.save
      redirect_to health_checks_path
    else
      render :new, status: :other
    end
  end

  def edit
  end

  def update

  end

  private

  def health_check_params
    params.require(:health_check).permit(:date, :clinic, :set_up_id)
  end

  def set_set_up
    @set_up = SetUp.find(params[:set_up_id])
  end
end
