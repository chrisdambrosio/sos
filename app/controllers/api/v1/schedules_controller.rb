class Api::V1::SchedulesController < Api::V1::BaseController
  def index
    super
  end

  def create
  end

  def show
    @response = @class.find params[:id]

    if params[:since] && params[:until]
      @since = Time.parse(params[:since])
      @until = Time.parse(params[:until])
      @response.schedule_layers.each do |sl|
        sl.schedule_entries =
          sl.timeline_entries(@since, @until)
      end
    end

    respond_after
  end

  def update
  end

  def destroy
  end

  private

  def strong_params
    params.require(:schedule).permit(:name)
  end
end
