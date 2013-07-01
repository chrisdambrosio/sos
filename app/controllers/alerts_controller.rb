class AlertsController < ApplicationController
  def show
    @alert = Alert.find(params[:id])
    @page_header = "Details for: Alert ##{@alert.id}"
  end
end
