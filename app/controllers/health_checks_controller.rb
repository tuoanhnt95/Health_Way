class HealthChecksController < ApplicationController
  before_action :set_health_check, only: %i[show edit update]

  def index
    @health_checks = policy_scope(HealthCheck)
  end

  def show
    authorize @health_check
  end

  def new
  end

  def edit
    authorize @health_check
  end

  def update
    authorize @health_check
    if @health_check.update(params[:health_check])
      redirect_to health_check_path(@health_check)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_health_check
    @health_check = HealthCheck.find(params[:id])
  end
end
