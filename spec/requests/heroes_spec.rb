require 'rails_helper'

RSpec.describe "Heroes", type: :request do
  before do
    h1 = Hero.create(name: "Kamala Khan", super_name: "Ms. Marvel")
    h2 = Hero.create(name: "Doreen Green", super_name: "Squirrel Girl")
    p1 = Power.create(name: "super strength", description: "gives the wielder super-human strengths")
    p2 = Power.create(name: "flight", description: "gives the wielder the ability to fly through the skies at supersonic speed")
    HeroPower.create(hero_id: h1.id, power_id: p1.id, strength: "Strong")
    HeroPower.create(hero_id: h1.id, power_id: p2.id, strength: "Strong")
    HeroPower.create(hero_id: h2.id, power_id: p2.id, strength: "Average")
  end

  describe "GET /heroes" do
    it 'returns an array of all heroes' do
      get '/heroes'

      expect(response.body).to include_json([
        { 
          id: a_kind_of(Integer), 
          name: "Kamala Khan", 
          super_name: "Ms. Marvel" 
        },
        { 
          id: a_kind_of(Integer), 
          name: "Doreen Green", 
          super_name: "Squirrel Girl" 
        }
      ])
    end

    it 'returns a status of 200 (OK)' do
      get "/heroes"
      
      expect(response).to have_http_status(:ok)
    end

    it 'does not return any nested powers' do
      get '/heroes'

      expect(response.body).not_to include_json([
        {
          powers: a_kind_of(Array)
        }
      ])
    end
  end

  describe "GET /heroes/:id" do
    
    context "with a valid ID" do

      it "returns the matching hero with its associated powers" do
        get "/heroes/#{Hero.first.id}"

        expect(response.body).to include_json({
          id: a_kind_of(Integer),
          name: "Kamala Khan", 
          super_name: "Ms. Marvel",
          powers: [
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
          ]
        })
      end
      
      it 'returns a status of 200 (OK)' do
        get "/heroes/#{Hero.first.id}"

        expect(response).to have_http_status(:ok)
      end
    end

    context "with an invalid ID" do
      
      it "returns an error message" do
        get "/heroes/bad_id"
        expect(response.body).to include_json({
          error: "Hero not found"
        })
      end
      
      it "returns the appropriate HTTP status code" do
        get "/heroes/bad_id"
        expect(response).to have_http_status(:not_found)
      end

    end

  end

end
