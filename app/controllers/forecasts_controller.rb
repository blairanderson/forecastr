class ForecastsController < ApplicationController
  before_action :require_authentication

  def create
    data = params.require(:data).permit!.to_h
    count = params[:count] || 10
    decimals = params[:decimals] || 2

    begin
      result = Prophet.forecast(data, count: count)
      result.transform_values! do |fcast|
        [ fcast.to_f.round(decimals), 0 ].max
      end
      render json: {
        result: result,
        result_info: {
          count: count,
          decimals: decimals
        }
      }, status: :ok
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end
