class CommentsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        article = Article.find(params[:article_id])
        comments = article.comments
        # render json: comments
        render json: comments, include: { user: [:profile]}
    end

    def new
        article = Article.find(params[:article_id])
        @comment = article.comments.build

    end

    def create
        article = current_user.Article.find(params[:article_id])
        @comment = article.comments.build(comment_params)
        @comment.save!

        render json: @comment
    end


    private
        def comment_params
            params.require(:comment).permit(:content)
        end
end
