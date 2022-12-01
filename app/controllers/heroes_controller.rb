class HeroesController < ApplicationController
    rescue_from  ActiveRecord::RecordNotFound, with: :record_not_found_response
    def index
        render json: Hero.all
    end

    def show
        hero = Hero.find(params[:id])
        render json: hero, serializer: HeroWithPowersSerializer
    end

    private

    def record_not_found_response(exception)
        render json: { "error": "Hero not found" }, status: :not_found
    end
end
