class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, except: :index
  #after_action :verify_policy_scoped, only: :index
  protect_from_forgery with: :exception
  include SessionsHelper

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def require_sign_in
    unless current_user
      flash[:alert] = "You must be logged in to do that"
      redirect_to new_session_path
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
