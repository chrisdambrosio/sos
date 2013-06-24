class Api::V1::AlertsController < Api::V1::BaseController
  respond_to :json
  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @response = Alert.all
    respond_after
  end

  def show
    @response = Alert.find params[:id]
    respond_after
  end

  def update
    set_user
    @response = Alert.find params[:id]
    @response.update_attributes(strong_params)
    respond_after
  end

  def create
    set_user
    @response = Alert.create(strong_params)
    SuckerPunch::Queue[:alert_queue].async.perform
    respond_after
  end

  def destroy
    @response = Alert.find params[:id]
    @response.destroy
    respond_after
  end

  private

  def strong_params
    @strong_params ||=
      params.require(:alert).permit(:description, :assigned_to)
  end

  def respond_after
    respond_with :api, :v1, @response
  end

  def set_user
    strong_params[:assigned_to] = User.find(strong_params[:assigned_to])
  end

  def record_not_found(error)
    render json: { error: 'not found' }, status: :not_found
  end

  def internal_server_error
    render json: { error: 'internal server error' }, status: :internal_server_error
  end
end
