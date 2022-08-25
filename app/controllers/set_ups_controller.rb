class SetUpsController < ApplicationController
  before_action :set_set_up, only: [:show]
  before_action :check_admin, only: [:index, :show]
  def index
    @set_ups = policy_scope(SetUp)
  end

  def show
    authorize @set_up
    @appointment_rate = ((@set_up.health_checks.count) / (@set_up.company.users.count).to_f * 100).ceil
    @complete = 0
    @set_up.health_checks.each do |health_check|
      if health_check.result.attached?
        @complete += 1
      end
    end
    @complete_rate = (@complete / (@set_up.company.users.count).to_f * 100).ceil
  end

  def new
    @clinics = Clinic.all
    @set_up = SetUp.new
    authorize @set_up
  end

  def create
    @set_up = SetUp.new(start_date: set_up_params[:start_date], end_date: set_up_params[:end_date])
    authorize @set_up
    @set_up.company = current_user.company
    set_up_params[:clinics].reject(&:blank?).each do |clinic_id|
      @clinic_set_up = ClinicSetUp.create(set_up: @set_up, clinic_id: clinic_id)
      @clinic_set_up.save
      @set_up.clinic_set_ups << @clinic_set_up
    end

    if @set_up.save
      redirect_to set_up_path(@set_up)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_up_params
    params[:set_up][:clinics].reject! { |clinic| clinic.empty? }
    params.require(:set_up).permit(:start_date, :end_date, clinics:[])
  end

  def set_set_up
    @set_up = SetUp.find(params[:id])
  end

  def check_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_back(fallback_location: health_checks_path)
    end
  end
end
