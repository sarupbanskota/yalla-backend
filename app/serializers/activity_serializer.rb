class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :action
  has_one :request
  has_one :user
end
