class NotificationsController < ApplicationController

  def read_all
    @notifications = current_user.notifications.where(type: "HealthCheckNotification")
    authorize @notifications
    @notifications.mark_as_read!
    if request.xhr?
      render json: {success: true}
    end

  end



end
