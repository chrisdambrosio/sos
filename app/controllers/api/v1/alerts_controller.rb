class Api::V1::AlertsController < Api::V1::BaseController
  before_action :set_agent, only: [:create, :update]
  before_action :set_channel, only: [:create, :update]

  def update
    set_user if strong_params[:assigned_to]
    status_name = strong_params.delete('status')
    @response = @class.find params[:id]
    if @response.update_attributes(strong_params)
      @response.fire_status_event(status_name) if status_name
    end
    respond_after
  end

  def create
    set_user
    strong_params.delete('status')
    @response = Alert.new(strong_params)
    if @response = Alert.create(strong_params)
      #SuckerPunch::Queue[:alert_queue].async.perform
    end
    respond_after
  end

  private

  def strong_params
    @strong_params ||=
      params.require(:alert).permit(:description, :details, :assigned_to, :status)
  end

  def set_user
    strong_params[:assigned_to] = User.find(strong_params[:assigned_to])
  end

  def set_agent
    strong_params[:agent] = current_user
  end

  def set_channel
    strong_params[:channel] = { type: 'website' }.to_json
  end
end
