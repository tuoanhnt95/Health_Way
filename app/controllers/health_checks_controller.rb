class HealthChecksController < ApplicationController
  def index
    @health_check = HealthCheck.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
