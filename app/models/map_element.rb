class MapElement < ApplicationRecord
    belongs_to :map

    validates :avatar_index, presence: true
    
end
