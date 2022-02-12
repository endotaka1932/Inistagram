class LikesController < ApplicationController

    def create
        article = Article.find(params[:article_id])
        article.likes.create!(user_id: current_user.id)
    end
end