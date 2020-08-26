class CommentsController < ApplicationController
  before_action :set_article

  def create
    @commment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'Comment has been added'
    else
      flash.now[:alert] = 'Comment has not been added'
    end
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
