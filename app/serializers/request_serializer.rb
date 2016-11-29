class RequestSerializer < ActiveModel::Serializer
  attributes :id, :from, :to, :description, :status
end
