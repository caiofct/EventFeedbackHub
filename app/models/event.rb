class Event < ApplicationRecord
  has_many :feedbacks, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
