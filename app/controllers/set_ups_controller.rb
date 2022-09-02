class SetUpsController < ApplicationController
  before_action :set_set_up, only: [:show]
  before_action :check_admin, only: [:index, :show]

  def index
    @set_ups = policy_scope(SetUp)
    @employee_count = User.all.count
  end

  def show
    authorize @set_up
    health_checks = @set_up.health_checks
    @appointment_count = health_checks.count
    complete_health_checks = health_checks.includes(:user).joins(:result_attachment)
    @completion_count = complete_health_checks.count
    employees = @set_up.company.users
    @employee_count = employees.count

    @appointment_rate = calculate_rate(@appointment_count, @employee_count)
    @complete_rate = calculate_rate(complete_health_checks.count, @employee_count)

    @no_appointment_emps = employees.where.not(id: @set_up.users).order('LOWER(first_name)')
    @no_result_checks = health_checks.includes(:user).where.not(id: complete_health_checks).order(date: :asc)
  end

  def new
    @clinics = Clinic.includes(:health_checks).all
    @top_clinics = Clinic.joins(:health_checks).select("clinics.*, COUNT(*) AS count").group("clinics.id").order(count: :desc).first(5)
    @set_up = SetUp.new
    authorize @set_up
  end

  def create
    @set_up = SetUp.new(start_date: set_up_params[:start_date], end_date: set_up_params[:end_date])
    authorize @set_up
    @set_up.company = current_user.company
    if @set_up.save
      send_noti(@set_up)
      redirect_to set_up_path(@set_up)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_up_params
    params.require(:set_up).permit(:start_date, :end_date)
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

  def send_noti(set_up)
    notification = SetUpNotification.with(set_up: set_up)
    notification.deliver(set_up.company.users)
    @message = message
    SlackNotifier.new.send(@message)
  end

  def find_complete_rate(set_up, employee_count)
    complete = 0
    set_up.health_checks.each do |health_check|
      if health_check.result.attached?
        complete += 1
      end
    end
    (complete / employee_count.to_f * 100).ceil
  end

  def calculate_rate(finished_number, total_number)
    (finished_number / total_number.to_f * 100).ceil
  end

  def message
    {
      "blocks": [
        {
          "type": "header",
          "text": {
            "type": "plain_text",
            "text": "Yearly Health Checks  :health_worker::hospital:",
            "emoji": true
          }
        },
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": "Go and get your Health Checks done people! Click on the link and fill out the form! :page_facing_up:"
          },
          "accessory": {
            "type": "button",
            "text": {
              "type": "plain_text",
              "text": "Health Way",
              "emoji": true
            },
            "value": "click_me_123",
            "url": "http://www.healthway.live/set_ups/#{@set_up.id}/health_checks/new)",
            "action_id": "button-action"
          }
        }
      ]
    }
  end
end
