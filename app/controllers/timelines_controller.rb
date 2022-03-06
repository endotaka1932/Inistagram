class TimelinesController < ApplicationController
    before_action :authenticate_user!

    def show
        user_ids = current_user.followings.pluck(:id)
        @articles = Article.where("user_id IN (?) and created_at >= ?", user_ids, Time.zone.now - 1.day).order(likes_count: :DESC)
    end
end