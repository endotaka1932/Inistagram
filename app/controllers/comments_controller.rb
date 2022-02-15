class CommentsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        article = Article.find(params[:article_id])
        comments = article.comments

        render json: comments
    end

    def new
        article = Article.find(params[:article_id])
        @comment = article.comments.build
    end

    def create
        article = Article.find(params[:article_id])
        @comment = article.comments.build(comment_params)
        if @comment.save
            redirect_to article_path(article), notice: 'コメント追加しました'
        else
            flash.now[:error] = '追加できませんでした'
            render :new
        end
    end


    private
        def comment_params
            params.require(:comment).permit(:content)
        end
end
