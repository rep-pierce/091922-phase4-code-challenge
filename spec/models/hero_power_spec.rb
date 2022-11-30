require 'rails_helper'

RSpec.describe HeroPower, type: :model do

  let(:hero) { Hero.create(name: "Kamala Khan", super_name: "Ms. Marvel") }
  let(:power) { Power.create(name: "super strength", description: "gives the wielder super-human strengths") }

  describe "relationships" do

    it 'can access the associated hero' do
      hero_power = HeroPower.create(hero_id: hero.id, power_id: power.id, strength: "Strong")

      expect(hero_power.hero).to eq(hero)
    end

    it 'can access the associated power' do
      hero_power = HeroPower.create(hero_id: hero.id, power_id: power.id, strength: "Strong")

      expect(hero_power.power).to eq(power)
    end
  
  end

  describe "validations" do

    it "must have a strength of one of the following values: 'Strong', 'Weak', 'Average'" do
      expect(HeroPower.create(hero_id: hero.id, power_id: power.id, strength: "Strong")).to be_valid
      expect(HeroPower.create(hero_id: hero.id, power_id: power.id, strength: "Weak")).to be_valid
      expect(HeroPower.create(hero_id: hero.id, power_id: power.id, strength: "Average")).to be_valid
      expect(HeroPower.create(hero_id: hero.id, power_id: power.id, strength: "OK")).to be_invalid
      expect(HeroPower.create(hero_id: hero.id, power_id: power.id)).to be_invalid
    end

  end

end
