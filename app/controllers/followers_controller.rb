class FollowersController < ApplicationController

    def index
        user = User.find(params[:account_id])
        user_ids = user.followers.pluck(:id)
        @followers = User.where(id: user_ids)
    end
end