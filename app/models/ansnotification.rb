class Ansnotification < ApplicationRecord
  belongs_to :user
  belongs_to :questionnaire
end
