class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_devise_params, if: :devise_controller?
  before_filter :can_can_can

  protected

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :email, :password)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username, :avatar, :email, :password,
               :password_confirmation, :current_password)
    end
  end

  private

  def can_can_can
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: 'Access denied.'
  end
end
