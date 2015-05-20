class Api::V1::TokenizerController < ApplicationController

  def generate_token
    token = Token.create(access_token: SecureRandom.hex(8))
    render json: {token: token}
  end

end
