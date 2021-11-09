class Map < ApplicationRecord
    belongs_to :campaign
    has_many :map_characters
end
