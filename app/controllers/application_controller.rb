class ApplicationController < ActionController::API
  before_action :authenticate_request, unless: :devise_controller?

  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers['Authorization']
    raise if header.blank?
    decoded = WebTokenManagement.decode_token( header.split(' ').last)
    @current_user = User.find(decoded[:sub])
  rescue
    render json: {error: 'unauthorized'}, status: :unauthorized
  end
end
