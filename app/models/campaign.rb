class Campaign < ApplicationRecord
    
    has_many :chat_messages
    has_many :campaign_users
    has_many :users, through: :campaign_users

    belongs_to :dm, :class_name => "User"

    validates :title, presence: true

end
