class Api::V1::SearchController < ApplicationController
  respond_to :json
  before_action :verify_params_exist, only: [:index]

  def index
    if search_params[:tacos] && search_params[:salsas]
      stores = find_stores_by_taco_ids(search_params) & find_stores_by_salsa_ids(search_params)
    elsif search_params[:tacos] && !search_params[:salsas]
      stores = find_stores_by_taco_ids(search_params)
    else
      stores = find_stores_by_salsa_ids(search_params)
    end
    respond_with stores
  end

  private

    def find_stores_by_taco_ids(params)
      ids = search_params[:tacos].split(',')
      count = ids.length
      Store.find_all_stores_with_specific_tacos(ids, count)
    end

    def find_stores_by_salsa_ids(params)
      ids = search_params[:salsas].split(',')
      count = ids.length
      Store.find_all_stores_with_specific_salsas(ids, count)
    end

    def verify_params_exist
      if search_params.empty?
        render status: 400, json: {
          error: "Must provide taco and/or salsa ids"
        }.to_json
      end
    end

    def search_params
      params.permit(:salsas,
                    :tacos
                   )
    end
end