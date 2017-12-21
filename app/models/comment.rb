class Comment < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :questionnaire
  has_many :notifications, dependent: :destroy
end
