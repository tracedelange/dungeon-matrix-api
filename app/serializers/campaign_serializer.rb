class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :is_dm, :dm_id

  has_many :users

  def is_dm
    self.object.dm_id == @instance_options[:user].id
  end
  
end