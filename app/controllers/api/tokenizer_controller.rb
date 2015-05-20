class Api::V1::TokenizerController < ApplicationController

  skip_before_action :verify_authenticity_token

  def generate_token
    token = Token.create(access_token: SecureRandom.hex(8))
    respond_with token
  end

end
