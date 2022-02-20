class FollowsController < ApplicationController
    before_action :authenticate_user!

    def show
        follow_status = current_user.has_followed?(params[:account_id])
        render json: { hasFollow: follow_status }
    end

    def create
        current_user.follow!(params[:account_id])
        
        render json: { status: 'ok' }
    end
end