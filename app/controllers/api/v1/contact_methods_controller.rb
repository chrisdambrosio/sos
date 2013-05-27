class Api::V1::ContactMethodsController < Api::V1::BaseController
  respond_to :json
  before_action :find_user
  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @contact_method = ContactMethod.where(user_id: @user.id)
    respond_after
  end

  def show
    @contact_method = ContactMethod.find params[:id]
    respond_after
  end

  def update
    @contact_method = ContactMethod.find params[:id]
    @contact_method.update_attributes(contact_method_params)
    respond_after
  end

  def create
    contact_method_params[:user_id] = User.find(params[:user_id])
    @contact_method = ContactMethod.create(
      contact_method_params.merge(user_id: @user.id)
    )
    respond_after
  end

  def destroy
    @contact_method = ContactMethod.find params[:id]
    @contact_method.destroy
    respond_after
  end

  private

  def contact_method_params
    params.require(:contact_method).permit(:label, :address, :type_id, :user_id)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def respond_after
    respond_with :api, :v1, @user, @contact_method
  end

  def record_not_found(error)
    render json: { error: 'not found' }, status: :not_found
  end

  def internal_server_error
    render json: { error: 'internal server error' }, status: :internal_server_error
  end
end
