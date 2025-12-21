class Advice < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  validates :date_on, presence: true
  validates :date_on, uniqueness: { scope: :user_id, message: "は1日1回までです" }
end

