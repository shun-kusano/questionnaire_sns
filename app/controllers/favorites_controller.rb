class FavoritesController < ApplicationController
  respond_to :html, :js

  def create
    @favorite = current_user.favorites.build(favorites_params)
    @favorite.save
    @questionnaire = Questionnaire.all.last
    push_when_create(@favorite)
    respond_with @questionnaire
  end

  def destroy
    @favorite = Favorite.find(params[:id].to_i)
    @questionnaire = @favorite.questionnaire
    @favorite.delete
    respond_with @questionnaire
  end

  def index
    @favorites_q = current_user.favorites_q.order(created_at: :desc)
  end

  private

  def favorites_params
    params.require(:favorite).permit([:questionnaire_id])
  end
end
