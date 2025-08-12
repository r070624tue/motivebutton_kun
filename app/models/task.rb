class Task < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  validates :date_on, presence: true
  validates :status, presence: true
end
