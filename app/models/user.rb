class User < ApplicationRecord
  has_many :requests
  has_many :activities

  scope :auth_id, -> (auth_id) { where auth_id: auth_id}

  def self.from_token_payload payload
    if payload['sub']
      self.find_or_create_by(auth_id: payload['sub'])
    end
  end

  def owner?
    self.role == 'owner'
  end
end
