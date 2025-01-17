class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_last_seen_at, if: :user_signed_in?

	layout "application"



	protected

	def authenticate_admin!
		authenticate_user!
		redirect_to error_403_path :status => 403, layout: false unless current_user.try(:admin?)
		# redirect_to "public/403.html", status: :forbidden unless current_user.admin?
	end

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
		devise_parameter_sanitizer.permit(:account_update, keys: [:username])
	end

	def set_last_seen_at
		current_user.touch(:last_seen_at)
	end
	
end
