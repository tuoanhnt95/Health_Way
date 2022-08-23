class HealthChecksController < ApplicationController
  def index
    @health_checks = policy_scope(HealthCheck)
  end

  def show
  end

  def new
  end

  def edit
  end

  private

  def method_name

  end
end
