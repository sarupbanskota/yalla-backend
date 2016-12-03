class RequestSerializer < ActiveModel::Serializer
  attributes :id, :from, :to, :description, :status, :requested_by, :username
end
