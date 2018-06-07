class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

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


  def delete
    @article = Article.find(params[:id])
  end

  def destroy
    article = Article.find(params[:id])
    if article.destroy
      flash[:notice] = "Successfully deleted article #{article.title}"
    else
      flash[:error] = "Couldn't delete article #{article.title}, try again!"
    end

    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
  end
end
