class Api::V1::AlertsController < Api::V1::BaseController
  before_action :get_assigned_to_user, only: [:create, :update]
  before_action :set_agent, only: [:create, :update]
  before_action :set_channel, only: [:create, :update]

  def update
    status_name = strong_params.delete('status')
    @response = @class.find params[:id]
    if @response.update_attributes(strong_params)
      if status_name && @response.status_events.include?(status_name.to_sym)
        @response.fire_status_event(status_name)
      end
    end
    respond_after
  end

  def create
    strong_params.delete('status')
    @response = Alert.new(strong_params)
    if @response = Alert.create(strong_params)
      SuckerPunch::Queue[:alert_queue].async.perform
    end
    respond_after
  end

  private

  def strong_params
    @strong_params ||=
      params.require(:alert).permit(:description, :details,
        :status, :assigned_to, :assigned_to => [:id])
  end

  def get_assigned_to_user
    if assigned_to = strong_params[:assigned_to]
      unless assigned_to.is_a?(Integer)
        assigned_to = assigned_to[:id]
      end
      # TODO: handle not found exception
      strong_params[:assigned_to] = User.find(assigned_to)
    end
  end

  def set_agent
    strong_params[:agent] = current_user
  end

  def set_channel
    strong_params[:channel] = { type: 'website' }.to_json
  end
end
