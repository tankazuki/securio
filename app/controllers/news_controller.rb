class NewsController < ApplicationController
  before_action :authenticate_admin!, only:[:new, :create, :edit, :update, :destroy]

  def site_information
    @many_news = News.where(news_type: 0).order(created_at: 'DESC')
  end

  def camera_information
    @many_news = News.where(news_type: 1).order(created_at: 'DESC')
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)
    if @news.save
      flash[:success] = "ニュースの投稿が完了しました"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @news = News.find(params[:id])
  end

  def edit
    @news = News.find(params[:id])
  end

  def update
    @news = News.find(params[:id])
    @news.update(news_params)
    if @news.save
      flash[:success] = "カメラの編集が完了しました"
      redirect_to admin_news_index_path
    else
      render 'edit'
    end
  end

  def destroy
    @news = News.find(params[:id])
    @news.destroy
    flash[:success] = "カメラの削除が完了しました"
    redirect_to admin_news_index_path
  end

  private
  def news_params
    params.require(:news).permit(:title, :content, :news_type, :news_image)
  end

end
