class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_admin!, only: [:destroy]
  before_action :authenticate_user!, only: [:update,:destroy]
  
  def edit 
    super
  end

  def create
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  private
  
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_referidor_id)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end
end