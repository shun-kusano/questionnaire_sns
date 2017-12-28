class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comments_params)
    @comment.user_id = current_user.id
    @cmtnotification = @comment.cmtnotifications.build(user_id: @comment.questionnaire.user.id )
    #@questionnaire = @comment.questionnaire
    respond_to do |format|
      #binding.pry
      if @comment.save
        unless @comment.questionnaire.user.id == current_user.id
          push_when_create(@comment)
        end
        format.html { redirect_to questionnaires_path, notice: 'コメントが投稿されました。'}
        format.js { render :index }
      else
        format.html { redirect_to questionnaires_path, notice: 'コメント作成時にエラーが起きました。' }
      end
    end
  end

def edit
  @comment = Comment.find(params[:id])
  @questionnaire = @comment.questionnaire
  respond_to do |format|
    format.js {render :edit}
  end
end

def update
  @comment = Comment.find(params[:id])
  if @comment.update(comments_params)
    redirect_to questionnaire_path(@comment.questionnaire.id), notice: "コメントを更新しました。"
  else
    redirect_to questionnaire_path(@comment.questionnaire.id), notice: "コメントを更新できませんでした。"
  end
end

def destroy
  @comment = Comment.find(params[:id])
  @questionnaire = @comment.questionnaire
  if @comment.destroy
    @comments = @questionnaire.comments
    respond_to do |format|
      format.html { redirect_to questionnaire_path(@questionnaire), notice: 'コメントを削除しました。'}
      format.js { render :destroy }
    end
  else
    @comments = @questionnaire.comments
    redirect_to questionnaire_path(@questionnaire), notice: 'コメントの削除ができません。'
  end
end

  private

  def comments_params
    params.require(:comment).permit([:questionnaire_id, :body])
  end
end
