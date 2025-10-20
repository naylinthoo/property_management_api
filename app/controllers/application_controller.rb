class ApplicationController < ActionController::API
  before_action :authenticate_api_key!

  private

  def authenticate_api_key!
    provided_key = request.headers['X-API-KEY']

    if provided_key.blank? || provided_key != ENV['API_KEY']
      render json: { error: 'Unauthorized: Invalid API key' }, status: :unauthorized
    end
  end
end
