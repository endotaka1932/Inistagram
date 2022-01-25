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
        @article = current_user.articles.build(article_params)
        if @article.save
            redirect_to article_path(id: @article.id)
        else
            render :new
        end
    end

    def update
    end

    def edit
    end

    def destroy
    end

    private
        def article_params
            params.require(:article).permit(:images, :content)
        end
end
