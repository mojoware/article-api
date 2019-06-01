class Api::V1::ArticlesController < ApplicationController

  def index
    articles = Article.order('id ASC')
    render json: {status: 'SUCCESS', message: 'Loaded articles', data: articles}, status: :ok
  end

  def show
    article = Article.find params[:id]
    render json: {status: 'SUCCESS', message: 'Loaded article', data: article}, status: :ok
  end

  def create
    article = Article.new article_params
    if article.save
      render json: {status: 'SUCCESS', message: 'Saved article', data: article}, status: :ok      
    else
      render json: {status: 'ERROR', message: 'Could not save article', data: article.errors}, status: :unprocessable_entity     
    end
  end

  def update
    article = Article.find params[:id]
    if article.update_attributes article_params
      render json: {status: 'SUCCESS', message: 'Updated article', data: article}, status: :ok    
    else
      render json: {status: 'ERROR', message: 'Could not update article', data: article.errors}, status: :unprocessable_entity      
    end
  end

  def destroy
    article = Article.find params[:id]
    article.destroy
    render json: {status: 'SUCCESS', message: 'Destroyed article', data: article}, status: :ok    
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

end
