class Request < ApplicationRecord
  attr_accessor :requested_by
  
  belongs_to :user
  has_many :activities
end
