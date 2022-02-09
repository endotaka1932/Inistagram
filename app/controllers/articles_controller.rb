class ArticlesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        @articles = Article.all
    end 

    def show
        @articles = current_user.articles.all
    end

    def new
        @article = current_user.articles.build
    end

    def create
        @article = current_user.articles.build(article_params)
        if @article.save
            redirect_to articles_path, notice: '投稿しました'
        else
            flash.now[:error] = '投稿に失敗しました'
            render :new
        end
    end

    def edit
        @article = current_user.articles.find(params[:id])
    end

    def update
        @article = current_user.articles.find(params[:id])
        if @article.update(article_params)
            redirect_to profile_path, notice: '更新しました'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end
    end

    def destroy
        @article = current_user.articles.find(params[:id])
        if @article.destroy!
            redirect_to profile_path, notice: '削除しました'
        end
    end

    private
        def article_params
            params.require(:article).permit(:content, images: [])
        end

end
