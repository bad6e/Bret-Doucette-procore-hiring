class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :city
end