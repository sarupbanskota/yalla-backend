class Request < ApplicationRecord
  attr_accessor :requested_by

  assignable_values_for :status do
    ['Pending', 'Accepted', 'Rejected']
  end

  scope :status, -> (status) { where status: status}
  scope :username, -> (username) { where("username ilike ?", "%#{username}%") }

  belongs_to :user
  has_many :activities
end
