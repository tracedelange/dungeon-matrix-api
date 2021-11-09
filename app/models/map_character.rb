class MapCharacter < ApplicationRecord
    belongs_to :map
    belongs_to :user, optional: true
    belongs_to :character
end
