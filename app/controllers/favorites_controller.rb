class FavoritesController < ApplicationController
  #respond_to :html, :js

  def create
    @favorite = current_user.favorites.build(favorites_params)
    @favorite.save
    @questionnaire = Questionnaire.find_by(id: favorites_params[:questionnaire_id].to_i)
    push_when_create(@favorite)
    respond_to do |format|
      format.html { redirect_to questionnaire_path(@questionnaire), notice: 'このアンケートをお気に入りにしました。' }
      format.js { render 'form' }
    end
  #respond_with @questionnaire
  end

  def destroy
    @favorite = Favorite.find(params[:id].to_i)
    @questionnaire = @favorite.questionnaire
    if @favorite.delete
      respond_to do |format|
        format.html { redirect_to questionnaire_path(@questionnaire), notice: 'お気に入りを解除しました。' }
        format.js { render 'form' }
      end
    else
      format.html { redirect_to questionnaire_path(@questionnaire), alert: 'お気に入りを解除できませんでした。' }
    end
  end

  def index
    @favorites_q = current_user.favorites_q.order(created_at: :desc)
  end

  private

  def favorites_params
    params.require(:favorite).permit([:questionnaire_id])
  end
end
