# To deliver this notification:
#
# SetUpNotification.with(post: @post).deliver_later(current_user)
# SetUpNotification.with(post: @post).deliver(current_user)
# SetUpNotification.with(set_up: @set_up).deliver(@set_up.company.users)

class SetUpNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :set_up

  # Define helper methods to make rendering easier.
  #
  def message
    "Schedule new health check for #{params[:set_up].start_date}-#{params[:set_up].end_date}"
  end
  #
  def url
    new_set_up_health_check_path(params[:set_up])
  end
end
