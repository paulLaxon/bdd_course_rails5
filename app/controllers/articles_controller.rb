# frozen_string_literal: true

# class
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show index]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article has been created'
      redirect_to articles_path
    else
      flash.now[:danger] = 'Article has not been created'
      render :new
    end
  end

  def show; end

  def edit
    return if @article.user == current_user

    flash[:alert] = 'You need to be the owner to edit an article.'
    redirect_to root_path
  end

  def update
    if current_user == @article.user
      if @article.update(article_params)
        flash[:success] = 'Article has been updated'
        redirect_to @article
      else
        flash.now[:danger] = 'Article has not been updated'
        render :edit
      end
    else
      flash.now[:danger] = 'You need to be the owner to edit an article.'
      redirect_to root_path
    end
  end

  def destroy
    return unless @article.destroy

    flash[:alert] = 'Article has been deleted'
    redirect_to root_path
  end

  protected

  def resource_not_found
    message = 'The article you are looking for could not be found'
    flash[:alert] = message
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
