class MapSerializer < ActiveModel::Serializer
  attributes :id
  has_many :map_characters
  has_many :map_elements
end
