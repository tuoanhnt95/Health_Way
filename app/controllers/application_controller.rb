class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_notification
  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end
def set_notification
  if user_signed_in?
    @set_up_notifications = current_user.notifications.where(type: "SetUpNotification")
    @health_check_notifications = current_user.notifications.where(type: "HealthCheckNotification")
    @result_notifications = current_user.notifications.where(type: "ResultNotification")
    @unread_set_up_notifications = @set_up_notifications.select{ |notification| notification.unread? }.count
    @unread_health_check_notifications = @health_check_notifications.select{ |notification| notification.unread? }.count
    @unread_result_notifications = @result_notifications.select{ |notification| notification.unread? }.count
    if current_user.admin
      @unread_notifications = @unread_set_up_notifications + @unread_health_check_notifications + @unread_result_notifications
    else
      @unread_notifications = @unread_set_up_notifications + @unread_result_notifications
    end
  end
end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
