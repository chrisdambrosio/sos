class Api::V1::UsersController < Api::V1::BaseController
  respond_to :json
  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @response = User.all
    respond_after
  end

  def show
    @response = User.find params[:id]
    respond_after
  end

  def update
    @response = User.find params[:id]
    @response.update_attributes(strong_params)
    respond_after
  end

  def create
    @response = User.create(strong_params)
    respond_after
  end

  def destroy
    @response = User.find params[:id]
    @response.destroy
    respond_after
  end

  private

  def strong_params
    params.require(:user).permit(:name, :email)
  end

  def respond_after
    respond_with :api, :v1, @response
  end

  def record_not_found(error)
    render json: { error: 'not found' }, status: :not_found
  end

  def internal_server_error
    render json: { error: 'internal server error' }, status: :internal_server_error
  end
end
