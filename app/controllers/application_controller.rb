class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :notification_count

  def push_when_create(answer_or_comment_or_favorite)
    if answer_or_comment_or_favorite.class.name == 'Comment' # input: comment
      comment = answer_or_comment_or_favorite
      user = comment.questionnaire.user
      @cmtnotification = comment.cmtnotifications.build(user_id: user.id)
      @cmtnotification.save
      Pusher.trigger("user_#{user.id}_channel", 'comment_created', {
       message: 'あなたの作成したアンケートにコメントがありました！'
      })
    elsif answer_or_comment_or_favorite.class.name == 'Favorite'# input: favorite
      questionnaire = answer_or_comment_or_favorite.questionnaire
      user = questionnaire.user
      @favnotification = questionnaire.favnotifications.build(user_id: user.id)
      @favnotification.save
    else #input: answer's
      questionnaire = answer_or_comment_or_favorite.questionnaire
      user = questionnaire.user
      @ansnotification = questionnaire.ansnotifications.build(user_id: user.id)
      @ansnotification.save
      Pusher.trigger("user_#{user.id}_channel", 'answer_created', {
       message: 'あなたの作成したアンケートに回答がありました！'
      })
    end
    push_count(user)
  end

  def push_count(user)
    Pusher.trigger("user_#{user.id}_channel", 'notification_created', {
      unread_flag: notification_count(user)
    })
  end

  def notification_count(user)
    cmtnotifications_num = Cmtnotification.where(read: false).where(user_id: user.id).count
    ansnotifications_num = Ansnotification.where(answered: false).where(user_id: user.id).count
    favnotifications_num = Favnotification.where(read: false).where(user_id: user.id).count
    @notifications_num = cmtnotifications_num + ansnotifications_num + favnotifications_num
  end

    protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar, :avatar_cache, :password, :password_confirmation])
  end

end
