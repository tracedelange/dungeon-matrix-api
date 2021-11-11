class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :created_at, :characters

  has_many :characters
end
