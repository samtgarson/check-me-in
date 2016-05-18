class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_for_both, only: :home
  protect_from_forgery with: :exception

  def home
  end

  def login
    render 'devise/sessions/new'
  end

  protected

  def check_for_both
    redirect_to login_path unless current_user.registered?
  end
end
