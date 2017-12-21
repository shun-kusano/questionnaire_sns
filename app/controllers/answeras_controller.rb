class AnswerasController < ApplicationController
  before_action :set_answera, only: [:edit, :update, :destroy]

  def new
    @answera = Answera.new
  end

  def create
    @answera = Answera.new(answeras_params)
    @questionnaire = @answera.questionnaire
    if @answera.save
      @questionnaire.ansnotifications.build(user_id: @questionnaire.user.id)
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
    @questionnaire = @answera.questionnaire
    if @answera.destroy
      redirect_to questionnaire_path(@questionnaire), notice: "回答を取り消しました。"
    else
      redirect_to questionnaire_path(@questionnaire), notice: '回答を取り消せませんでした。'
    end
  end

  private

  def answeras_params
      params.require(:answera).permit([:questionnaire_id, :user_id])
  end

  def set_answera
    @answera = Answera.find(params[:id])
  end

end
