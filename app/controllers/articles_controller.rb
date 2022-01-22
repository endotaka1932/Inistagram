class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end 

    def show
    end

    def new
        @article = current_user.articles.build
    end

    def create
    end

    def update
    end

    def edit
    end

    def destroy
    end
end
