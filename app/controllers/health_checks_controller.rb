class HealthChecksController < ApplicationController
  before_action :set_set_up, only: %i[new create]
  before_action :set_health_check, only: %i[show edit update]

  def index
    @health_checks = policy_scope(HealthCheck)
  end

  def show
    authorize @health_check
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
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @health_check
    @clinics = Clinic.all
    @markers = @clinics.geocoded.map do |clinic|
      {
        lat: clinic.latitude,
        lng: clinic.longitude,
        info_window: render_to_string(partial: "info_window", locals: { clinic: clinic })
      }
    end
  end

  def update
    authorize @health_check
    if @health_check.update(health_check_params)
      redirect_to health_check_path(@health_check)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_set_up
    @set_up = SetUp.find(params[:set_up_id])
  end

  def set_health_check
    @health_check = HealthCheck.find(params[:id])
  end

  def health_check_params
    params.require(:health_check).permit(:date, :clinic_id, :set_up_id)
  end
end
