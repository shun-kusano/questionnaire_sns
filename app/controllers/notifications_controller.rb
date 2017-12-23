class NotificationsController < ApplicationController
  def index
    @cmtnotifications = Cmtnotification.where(read: false).where(user_id: current_user.id).order(created_at: :desc)
    @ansnotifications = Ansnotification.where(answered: false).where(user_id: current_user.id).order(created_at: :desc)
    @favnotifications = Favnotification.where(read: false).where(user_id: current_user.id).order(created_at: :desc)
  end
end
