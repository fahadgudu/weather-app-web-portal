class Api::V1::TokenizerController < ApplicationController

  swagger_controller :tokenizer, "Generate token for API"

  swagger_api :generate_token do
    summary "Generates token to access APIs"
    notes "Generates token to access APIs"
  end

  def generate_token
    token = Token.create(access_token: SecureRandom.hex(8))
    render json: {token: token}
  end

end
