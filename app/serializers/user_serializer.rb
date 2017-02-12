class UserSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :auth_id,
             :country, :date_of_joining, :updated_at,
             :email, :timezone, :avatar,
             :first_name, :last_name
end
