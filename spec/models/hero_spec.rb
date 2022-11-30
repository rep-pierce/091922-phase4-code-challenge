require 'rails_helper'

RSpec.describe Hero, type: :model do
  
  describe "relationships" do

    let(:hero) { Hero.create(name: "Kamala Khan", super_name: "Ms. Marvel") }
    let(:power) { Power.create(name: "super strength", description: "gives the wielder super-human strengths") }
  
    it 'can access the associated hero_powers' do
      hero_power = HeroPower.create(hero_id: hero.id, power_id: power.id, strength: "Strong")
  
      expect(hero.hero_powers).to include(hero_power)
    end
  
    it 'can access the associated powers' do
      HeroPower.create(hero_id: hero.id, power_id: power.id, strength: "Strong")
  
      expect(hero.powers).to include(power)
    end

  end

end
