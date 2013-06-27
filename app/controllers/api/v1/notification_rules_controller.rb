class Api::V1::NotificationRulesController < Api::V1::BaseController
  before_action :find_user

  def index
    @query = @user.notification_rules
    super
  end

  def create
    strong_params[:user_id] = @user
    super
  end

  private

  def strong_params
    params.require(:notification_rule).
      permit(:contact_method_id, :start_delay)
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
