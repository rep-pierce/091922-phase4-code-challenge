class HeroPowerSerializer < ActiveModel::Serializer
  attributes :id, :strength
  has_one :hero
  has_one :power
end
