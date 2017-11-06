class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @articles = Article.all.order(created_at: :desc)
  end

  def show

  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article, notice: "The article was created successfully."
    else
      render :new, notice: "The article failed to be created."
    end
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      redirect_to @article, notice: "The article was updated successfully."
    else
      render :edit, notice: "The article failed to be updated"
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def set_article
    @article = current_user.articles.find(params[:id])
  end
end
