class Api::V1::UsersController < Api::V1::BaseController
  private

  def strong_params
    params.require(:user).permit(:name, :email, :password)
  end
end
