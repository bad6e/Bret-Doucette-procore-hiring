class Api::V1::SearchController < ApplicationController
  respond_to :json

  def index
    if search_params[:tacos] && search_params[:salsas]
      taco_ids = search_params[:tacos].split(',')
      salsa_ids = search_params[:salsas].split(',')
      stores = Store.find_tacos_by_ids(taco_ids).group_results(taco_ids.count) & Store.find_salsas_by_ids(salsa_ids).group_results(salsa_ids.count)
      respond_with stores
    elsif search_params[:tacos] && !search_params[:salsas]
      taco_ids = search_params[:tacos].split(',')
      stores = Store.find_tacos_by_ids(taco_ids).group_results(taco_ids.count)
      respond_with stores
    elsif !search_params[:tacos] && search_params[:salsas]
      salsa_ids = search_params[:salsas].split(',')
      stores = Store.find_salsas_by_ids(salsa_ids).group_results(salsa_ids.count)
      respond_with stores
    else
      respond_with ''
    end
  end

  private

    def search_params
      params.permit(:salsas,
                    :tacos
                   )
    end
end
