class Api::V1::SchedulesController < Api::V1::BaseController
  def index
    super
  end

  def create
  end

  def show
    @response = @class.find params[:id]

    if params[:since] && params[:until]
      @response.since = Time.parse(params[:since])
      @response.until = Time.parse(params[:until])
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
