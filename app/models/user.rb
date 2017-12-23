class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  mount_uploader :avatar, AvatarUploader #deviseの設定配下に追記

  has_many :questionnaires, dependent: :destroy
  has_many :comments, dependent: :destroy

  #answer
  has_many :answeras, dependent: :destroy
  has_many :answerbs, dependent: :destroy
  has_many :answered_a_qs, :through => :answeras, :source => 'questionnaire'
  has_many :answered_b_qs, :through => :answerbs, :source => 'questionnaire'

 #通知
  has_many :ansnotifications, dependent: :destroy
  has_many :cmtnotifications, dependent: :destroy
  has_many :favnotifications, dependent: :destroy

  # favorites questionnaires
  has_many :favorites, dependent: :destroy
  has_many :favorite_qs, :through => :favorites, :source => 'questionnaire'

  def update_with_password(params, *options)
    if provider.blank?
      super
    else
      params.delete :current_password
      update_without_password(params, *options)
    end
  end

   def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
     user = User.find_by(provider: auth.provider, uid: auth.uid)

     unless user
       user = User.new(
           name:     auth.extra.raw_info.name,
           provider: auth.provider,
           uid:      auth.uid,
           email:    "#{auth.uid}-#{auth.provider}@example.com",
           image_url:   auth.info.image,
           password: Devise.friendly_token[0, 20]
       )
       user.skip_confirmation!
       user.save(validate: false)
     end
     user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(
          name:     auth.info.nickname,
          image_url: auth.info.image,
          provider: auth.provider,
          uid:      auth.uid,
          email:    "#{auth.uid}-#{auth.provider}@example.com",
          password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save
    end
    user
  end


  def self.create_unique_string
      SecureRandom.uuid
  end

  def answered_qs
    self.answered_a_qs + self.answered_b_qs
  end
end
