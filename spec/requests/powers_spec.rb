require 'rails_helper'

RSpec.describe "Powers", type: :request do
  before do
    h1 = Hero.create(name: "Kamala Khan", super_name: "Ms. Marvel")
    h2 = Hero.create(name: "Doreen Green", super_name: "Squirrel Girl")
    p1 = Power.create(name: "super strength", description: "gives the wielder super-human strengths")
    p2 = Power.create(name: "flight", description: "gives the wielder the ability to fly through the skies at supersonic speed")
    HeroPower.create(hero_id: h1.id, power_id: p1.id, strength: "Strong")
    HeroPower.create(hero_id: h1.id, power_id: p2.id, strength: "Strong")
    HeroPower.create(hero_id: h2.id, power_id: p2.id, strength: "Average")
  end

  describe "GET /powers" do
    it 'returns an array of all powers' do
      get '/powers'

      expect(response.body).to include_json([
        { 
          id: a_kind_of(Integer), 
          name: "super strength", 
          description: "gives the wielder super-human strengths"
        },
        { 
          id: a_kind_of(Integer), 
          name: "flight", 
          description: "gives the wielder the ability to fly through the skies at supersonic speed"
        }
      ])
    end

    it 'returns a status of 200 (OK)' do
      get "/powers"

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /powers/:id" do

    context "with a valid ID" do

      it "returns the matching power" do
        get "/powers/#{Power.first.id}"
        
        expect(response.body).to include_json({
          id: a_kind_of(Integer),
          name: "super strength", 
          description: "gives the wielder super-human strengths"
        })
      end

      it 'returns a status of 200 (OK)' do
        get "/powers/#{Power.first.id}"

        expect(response).to have_http_status(:ok)
      end
    end

    context "with an invalid ID" do

      it "returns an error message" do
        get "/powers/bad_id"
        expect(response.body).to include_json({
          error: "Power not found"
        })
      end
      
      it "returns the appropriate HTTP status code" do
        get "/powers/bad_id"
        expect(response).to have_http_status(:not_found)
      end

    end

  end

  describe "PATCH /powers/:id" do
    
    context "with a valid ID and valid data" do

      it "updates the power's description" do
        patch "/powers/#{Power.first.id}", params: { description: "bestows super-human strengths upon the wielder" }
        expect(response.body).to include_json({
          id: a_kind_of(Integer),
          name: "super strength",
          description: "bestows super-human strengths upon the wielder"
        })
      end
      
    end
    
    context "with a valid ID and invalid data" do

      it "does not update the power's description" do
        patch "/powers/#{Power.first.id}", params: { description: "too short" }

        expect(Power.first.description).to eq("gives the wielder super-human strengths")
      end
      
      it 'returns the error messages as an array' do
        patch "/powers/#{Power.first.id}", params: { description: "too short" }

        expect(response.body).to include_json({
          errors: a_kind_of(Array)
        })
      end

      it 'returns a status code of 422 (Unprocessable Entity)' do
        patch "/powers/#{Power.first.id}", params: { description: "too short" }
  
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end

    context "with an invalid ID" do
      
      it "returns an error message" do
        get "/powers/bad_id"
        expect(response.body).to include_json({
          error: "Power not found"
        })
      end
      
      it "returns the appropriate HTTP status code" do
        get "/powers/bad_id"
        expect(response).to have_http_status(:not_found)
      end

    end

  end
  
end
