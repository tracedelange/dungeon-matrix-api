class MapCharacterSerializer < ActiveModel::Serializer
  attributes :id, :position_x, :position_y, :user_id, :username, :character

  # belongs_to :user

  def username
    if self.object.user_id
      user = User.find(self.object.user_id)
      user.username
    else
      false
    end
  end

end
