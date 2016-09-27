class Api::V1::SalsasController < ApplicationController
  respond_to :json

  def index
    respond_with Salsa.all
  end
end
