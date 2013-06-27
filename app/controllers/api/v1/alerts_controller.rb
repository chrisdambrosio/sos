class Api::V1::AlertsController < Api::V1::BaseController
  def update
    set_user
    super
  end

  def create
    set_user
    @response = Alert.create(strong_params)
    SuckerPunch::Queue[:alert_queue].async.perform
    respond_after
  end

  private

  def strong_params
    @strong_params ||=
      params.require(:alert).permit(:description, :assigned_to)
  end

  def set_user
    strong_params[:assigned_to] = User.find(strong_params[:assigned_to])
  end
end
