class AnswerbsController < ApplicationController
  before_action :set_answerb, only: [:edit, :update, :destroy]

  def new
    @answerb = Answerb.new
  end

  def create
    @answerb = Answerb.new(answerbs_params)
    @questionnaire = @answerb.questionnaire
    if @answerb.save
      @ansnotification = @questionnaire.ansnotifications.build(user_id: @questionnaire.user.id)
      @questionnaire.update
      Pusher.trigger("user_#{@questionnaire.user.id}_channel", 'answer_created', {
       message: 'あなたの作成したアンケートに回答がありました！'
      })
      redirect_to @questionnaire, notice: 'あなたの回答が加わりました！'
    else
      redirect_to @questionnaire, alert: '回答できませんでした。'
    end
  end

  def destroy
    @questionnaire = @answerb.questionnaire
    if @answerb.destroy
      redirect_to questionnaire_path(@questionnaire), notice: "回答を取り消しました。"
    else
      redirect_to questionnaire_path(@questionnaire), notice: '回答を取り消せませんでした。'
    end
  end

  private

  def answerbs_params
      params.require(:answerb).permit([:questionnaire_id, :user_id])
  end

  def set_answerb
    @answerb = Answerb.find(params[:id])
  end
end
