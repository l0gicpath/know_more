class ArticlesController < ApplicationController
  before_action :fetch_article, only: [:show, :edit, :update, :delete, :destroy]
  def index
    if params[:language] == "de"
      @articles = Article.where.not(de_content: [nil, ""]).order(created_at: :desc)
    else
      @articles = Article.order(created_at: :desc)
    end
  end

  def show;end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end


  def edit; end
  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end


  def delete; end
  def destroy
    if @article.destroy
      flash[:notice] = "Successfully deleted article #{@article.title}"
    else
      flash[:error] = "Couldn't delete article #{@article.title}, try again!"
    end

    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
  end

  def fetch_article
    @article = Article.find(params[:id])
  end
end
