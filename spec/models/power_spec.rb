require 'rails_helper'

RSpec.describe Power, type: :model do

  describe "relationships" do
      
    let(:hero) { Hero.create(name: "Kamala Khan", super_name: "Ms. Marvel") }
    let(:power) { Power.create(name: "super strength", description: "gives the wielder super-human strengths") }
  
    it 'can access the associated hero_powers' do
      hero_power = HeroPower.create(hero_id: hero.id, power_id: power.id, strength: "Strong")
  
      expect(power.hero_powers).to include(hero_power)
    end
  
    it 'can access the associated heroes' do
      HeroPower.create(hero_id: hero.id, power_id: power.id, strength: "Strong")
  
      expect(power.heroes).to include(hero)
    end

  end

  describe "validations" do

    it "must have a description with at least 20 characters" do
      expect(Power.create(name: "super strength", description: "gives the wielder super-human strengths")).to be_valid
      expect(Power.create(name: "super strength", description: "hi")).to be_invalid
      expect(Power.create(name: "super strength")).to be_invalid
    end

  end

end
