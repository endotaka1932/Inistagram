class FollowingsController < ApplicationController

    def index
        user = User.find(params[:account_id])
        user_ids = user.followings.pluck(:id)
        @followings = User.where(id: user_ids)
    end
end