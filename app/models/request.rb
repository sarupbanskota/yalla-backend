class Request < ApplicationRecord
  attr_accessor :requested_by

  assignable_values_for :status do
    ['Pending', 'Accepted', 'Rejected']
  end
  
  belongs_to :user
  has_many :activities
end
