class Api::V1::LogEntriesController < Api::V1::BaseController
  def index
    @query = LogEntry.where(alert: Alert.find(params[:alert_id]))
    super
  end
end
