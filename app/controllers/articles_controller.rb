class ArticlesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        @articles = Article.all
    end 

    def show
    end

    def new
        @article = current_user.articles.build
    end

    def create
        @article = current_user.articles.build(article_params)
        if @article.save
            redirect_to article_path(id: @article.id)
        else
            render :new
        end
    end

    def edit
        @article = current_user.articles.find(params[:id])
    end

    def update
        @article = current_user.articles.find(params[:id])
        if @article.update(article_params)
            redirect_to profile_path
        else
            render :edit
        end
    end

    def destroy
        @article = currrent_user.articles.find(params[:id])
        if @article.destroy!
            redirect_to profile_path
        end
    end

    private
        def article_params
            params.require(:article).permit(:content, images: [])
        end
end
