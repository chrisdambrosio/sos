class Api::V1::ContactMethodsController < Api::V1::BaseController
  respond_to :json

  def index
    @contact_methods = ContactMethod.all
    respond_with(@contact_methods)
  end

  def show
    @contact_method = ContactMethod.find params[:id]
    respond_with @contact_method
  end

  def update
    @contact_method = ContactMethod.find params[:id]
    @contact_method.update_attributes(contact_method_params)
    respond_with @contact_method
  end

  private

  def contact_method_params
    params.require(:contact_method).permit(:label, :address, :type_id, :user_id)
  end
end
