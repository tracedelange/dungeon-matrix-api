class Map < ApplicationRecord
    belongs_to :campaign
    has_many :map_characters
    has_many :map_elements
end
