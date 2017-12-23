class Favorite < ApplicationRecord
  validates :questionnaire_id, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, :scope => :questionnaire_id

  belongs_to :user
  belongs_to :questionnaire
end
