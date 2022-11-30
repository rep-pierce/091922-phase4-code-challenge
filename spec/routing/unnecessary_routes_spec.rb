require 'rails_helper'

RSpec.describe "Unnecessary Routes", type: :routing do
  
  it "does not define unnecessary hero routes" do
    expect(post: "/heroes").not_to be_routable
    expect(patch: "/heroes/1").not_to be_routable
    expect(delete: "/heroes/1").not_to be_routable
  end
  
  it "does not define unnecessary power routes" do
    expect(post: "/powers").not_to be_routable
    expect(delete: "/powers/1").not_to be_routable
  end
  
  it "does not define unnecessary hero_power routes" do
    expect(get: "/hero_powers").not_to be_routable
    expect(get: "/hero_powers/1").not_to be_routable
    expect(patch: "/hero_powers/1").not_to be_routable
    expect(delete: "/hero_powers/1").not_to be_routable
  end

end
