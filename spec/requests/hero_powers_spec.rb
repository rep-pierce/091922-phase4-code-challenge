require 'rails_helper'

RSpec.describe "HeroPowers", type: :request do
  let!(:h1) { Hero.create(name: "Kamala Khan", super_name: "Ms. Marvel") }
  let!(:p1) { Power.create(name: "super strength", description: "gives the wielder super-human strengths") }

  describe "POST /hero_powers" do
    
    context "with valid data" do
      let!(:hero_power_params) { { hero_id: h1.id, power_id: p1.id, strength: "Strong" } }

      it 'creates a new HeroPower' do
        expect { post '/hero_powers', params: hero_power_params }.to change(HeroPower, :count).by(1)
      end

      it 'returns the associated Hero data' do
        post '/hero_powers', params: hero_power_params

        expect(response.body).to include_json({
          id: a_kind_of(Integer),
          name: "Kamala Khan", 
          super_name: "Ms. Marvel",
          powers: [
            {
              id: a_kind_of(Integer),
              name: "super strength", 
              description: "gives the wielder super-human strengths"
            }
          ]
        })
      end

      it 'returns a status code of 201 (created)' do
        post '/hero_powers', params: hero_power_params

        expect(response).to have_http_status(:created)
      end

    end

    context "with invalid data" do
      let!(:invalid_params) { { hero_id: h1.id, power_id: p1.id, strength: "invalid" } }

      it 'does not create a new HeroPower' do
        expect { post '/hero_powers', params: invalid_params }.to change(HeroPower, :count).by(0)
      end

      it 'returns the error messages as an array' do
        post '/hero_powers', params: invalid_params

        expect(response.body).to include_json({
          errors: a_kind_of(Array)
        })
      end

      it 'returns a status code of 422 (Unprocessable Entity)' do
        post '/hero_powers', params: invalid_params
  
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

end
