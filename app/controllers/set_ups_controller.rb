class SetUpsController < ApplicationController
  def index
    @set_ups = policy_scope(SetUp)
  end

  def show
    @set_up = SetUp.find(params[:id])
    authorize @set_up
  end
end
