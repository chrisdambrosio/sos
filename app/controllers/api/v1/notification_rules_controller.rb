class Api::V1::NotificationRulesController < Api::V1::BaseController
  respond_to :json
  before_action :find_user
  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @notification_rule = @user.notification_rules
    respond_after
  end

  def show
    @notification_rule = NotificationRule.find params[:id]
    respond_after
  end

  def update
    @notification_rule = NotificationRule.find params[:id]
    @notification_rule.update_attributes(notification_rule_params)
    respond_after
  end

  def create
    notification_rule_params[:user_id] = User.find(params[:user_id])
    @notification_rule = NotificationRule.create(
      notification_rule_params
    )
    respond_after
  end

  def destroy
    @notification_rule = NotificationRule.find params[:id]
    @notification_rule.destroy
    respond_after
  end

  private

  def notification_rule_params
    params.require(:notification_rule).permit(:contact_method, :start_delay)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def respond_after
    respond_with :api, :v1, @user, @notification_rule
  end

  def record_not_found(error)
    render json: { error: 'not found' }, status: :not_found
  end

  def internal_server_error
    render json: { error: 'internal server error' }, status: :internal_server_error
  end
end
