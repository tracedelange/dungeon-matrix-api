class MapSerializer < ActiveModel::Serializer
  attributes :id, :width, :height, :background_index, :tile_index
  has_many :map_characters
  has_many :map_elements
end
