class QuestionnairesController < ApplicationController
  before_action :set_questionnaire, only: [:show, :edit, :update, :destroy]

  def create
    @questionnaire = Questionnaire.new(questionnaires_params)
    if @questionnaire.save
      redirect_to questionnaires_path, notice: '新しいアンケートを公開しました！'
    else
      redirect_to new_questionnaire_path, alert: 'アンケートの作成に失敗しました。'
    end
  end

  def edit
  end

  def update
    if @questionnaire.update(questionnaire_params)
      redirect_to questionnaires_path, notice: '新しいアンケートを公開しました！'
    else
      redirect_to new_questionnaire_path, alert: 'アンケートの作成に失敗しました。'
    end
  end

  def destroy
    if @questionnaire.destroy
      redirect_to questionnaires_path, notice: "アンケートを削除しました。"
    else
      redirect_to questionnaires_path, notice: 'アンケートを削除できませんでした。'
    end
  end

  def new
    @questionnaire = Questionnaire.new
  end

  def index
    @questionnaires = Questionnaire.all
  end

  def show
    @comments = @questionnaire.comments.all
    @comment = @questionnaire.comments.build
    @answera = @questionnaire.answeras.build
    @answerb = @questionnaire.answerbs.build

  end

  def confirm
    @questionnaire = Questionnaire.new(questionnaires_params)
    #binding.pry
    render :new if @questionnaire.invalid?
  end

  private

  def questionnaires_params
      params.require(:questionnaire).permit([:body, :qimage, :qimage_cache, :date_by, :user_id, :optiona_body, :optiona_image, :optiona_image_cache, :optionb_body, :optionb_image, :optionb_image_cache])
  end

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
    #@picture = @questionnaire.pictures.first
  end

end
