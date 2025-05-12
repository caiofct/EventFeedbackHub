class Feedback < ApplicationRecord
  belongs_to :event

  validates :user_name, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
end
