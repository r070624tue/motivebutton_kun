class Task < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  validates :date_on, presence: true
  validates :completed, presence: true
end
