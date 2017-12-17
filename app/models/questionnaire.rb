class Questionnaire < ApplicationRecord
  validates :body, presence: true
  belongs_to :user

  mount_uploader :qimage, QimageUploader #deviseの設定配下に追記

end
