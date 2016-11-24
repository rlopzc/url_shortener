class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include CanCan::ControllerAdditions
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  before_action :authenticate

  protected

  # Authenticate the user with token based authentication
  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @current_user = User.find_by(api_key: token)
    end
  end

  def render_unauthorized
    render json: {error: 'Bad credentials'}, status: :unauthorized
  end

  def current_user
    @current_user
  end

  rescue_from CanCan::AccessDenied do |_exception|
    head :forbidden
  end

  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end
end
