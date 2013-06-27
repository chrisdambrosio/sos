class Api::V1::BaseController < ActionController::Base
  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  responders :json
  respond_to :json
  before_action :get_limit,  only: [:index]
  before_action :get_offset, only: [:index]
  before_action :get_class

  def index
    @response = (@query || @class).limit(@limit).offset(@offset)
    respond_after
  end

  def show
    @response = @class.find params[:id]
    respond_after
  end

  def update
    @response = @class.find params[:id]
    @response.update_attributes(strong_params)
    respond_after
  end

  def create
    @response = @class.create(strong_params)
    respond_after
  end

  def destroy
    @response = @class.find params[:id]
    @response.destroy
    respond_after
  end

  private

  def get_class
    @class = controller_name.classify.constantize
  end

  def metadata
    if action_name == 'index'
      total = @class.count
      { meta: { total: total, limit: @limit, offset: @offset } }
    else
      {}
    end
  end

  def get_limit
    limit = params[:limit].to_i

    if limit > 0
      @limit = limit
    else
      @limit = 100
    end
  end

  def get_offset
    @offset = params[:offset].to_i
  end

  def record_not_found(error)
    render json: { error: 'not found' }, status: :not_found
  end

  def internal_server_error
    render json: { error: 'internal server error' }, status: :internal_server_error
  end

  def respond_after
    respond_with :api, :v1, @response, metadata
  end
end
