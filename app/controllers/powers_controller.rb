class PowersController < ApplicationController
    rescue_from  ActiveRecord::RecordNotFound, with: :record_not_found_response
    def index
        render json: Power.all
    end

    def show
        power = Power.find(params[:id])
        render json: power 
    end

    private

    def record_not_found_response(exception)
        render json: { "error": "Power not found" }, status: :not_found
    end
end
