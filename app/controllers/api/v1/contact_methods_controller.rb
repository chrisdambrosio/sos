class Api::V1::ContactMethodsController < Api::V1::BaseController
  before_action :find_user

  def index
    @query = ContactMethod.where(user_id: @user.id)
    super
  end

  def create
    strong_params[:user_id] = @user
    super
  end

  private

  def strong_params
    params.require(:contact_method).permit(:label, :address, :type_id, :contact_type, :user_id)
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
