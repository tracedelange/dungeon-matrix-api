class Character < ApplicationRecord
    belongs_to :user
    has_many :map_characters

    validates :name, presence: true
end
