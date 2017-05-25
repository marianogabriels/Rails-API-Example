class ApiController < ApplicationController
  before_action :validate_token, only: [:create]

  def new
    @token = token
  end

  def create
    api_service = ApiService.post_data(params[:commit], params[:api_data], token)
    if api_service.success?
      redirect_to new_post_path
    else
      render status: 400
    end
  end

  private

  def validate_token
    if token.expired?
      token.refresh
    end
  end

  def token
    Token.first
  end
end
