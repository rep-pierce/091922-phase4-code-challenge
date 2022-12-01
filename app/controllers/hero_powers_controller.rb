class HeroPowersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
    def create
        hero = HeroPower.create!(hero_power_params).hero
        render json: hero, serializer: HeroWithPowersSerializer, status: :created
    end

    private

    def hero_power_params
        params.permit(:price, :power_id, :hero_id)
    end

    def render_record_invalid(exception)
        render json: { "errors": exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
