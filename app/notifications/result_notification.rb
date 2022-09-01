# To deliver this notification:
#
# HealthCheckNotification.with(post: @post).deliver_later(current_user)
# HealthCheckNotification.with(post: @post).deliver(current_user)

class ResultNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :health_check

  # Define helper methods to make rendering easier.
  #
  def message
    "#{params[:health_check].user.first_name.capitalize} #{params[:health_check].user.last_name.capitalize} got a health check result"
  end
  #
  # def url
  #   post_path(params[:post])
  # end

  # def clear
  #   current_user.notifications.where(type: "Notification").destroy_all
  #   render nothing: true
  # end

end
