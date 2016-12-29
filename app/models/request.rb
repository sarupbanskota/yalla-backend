class Request < ApplicationRecord
  attr_accessor :requested_by
  belongs_to :user
  has_many :activities

  assignable_values_for :status do
    ['Pending', 'Accepted', 'Rejected']
  end

  scope :status, -> (status) { where status: status }

  scope :search, -> (query) {
    joins(:user).where("users.email ilike ?", "%#{query}%")
  }
end
