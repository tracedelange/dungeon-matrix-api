class MapSerializer < ActiveModel::Serializer
  attributes :id
  has_many :map_characters
end
