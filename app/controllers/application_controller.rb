class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  respond_to :html, :json

  before_filter :authenticate_token!, except: [:generate_token]

  def authenticate_token!
    return render_error("Problem with Authentication Token",401, 401) unless Token.find_by(access_token: params[:access_token])
  end

  private

  def render_error(description, code,status)
    render json: {error: error_message_for(description, code)}, status: status
  end

  def error_message_for(description, code)
    {
      error_code: code,
      error_description: description
    }
  end

end
