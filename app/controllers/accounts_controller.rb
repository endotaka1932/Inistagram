class AccountsController < ApplicationController

    def show
        @user = User.find(params[:id])
        @article = @user.articles.first
    end
end