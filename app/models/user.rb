class User < ApplicationRecord
  has_many :requests
  def self.from_token_payload payload
    if payload['sub']
      self.find_or_create_by auth_id: payload['sub']
    end
  end
end
