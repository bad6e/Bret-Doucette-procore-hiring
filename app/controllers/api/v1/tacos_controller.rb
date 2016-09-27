class Api::V1::TacosController < ApplicationController
  respond_to :json

  def index
    respond_with Taco.all
  end
end
