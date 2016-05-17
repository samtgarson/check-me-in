class SettingsController < ApplicationController
  def edit
  end

  def update
    current_user.update_attributes user_params
    render :edit
  end

  private

  def user_params
    params.require(:user).permit(Merchant::CATEGORIES)
  end
end
