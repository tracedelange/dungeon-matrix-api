class ChatMessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :author, :created_at

  def author
    User.find(self.object.author_id).username
  end
end
