class UnfollowsController < ApplicationController
    before_action :authenticate_user!

    def index
    end

    def create
        current_user.unfollow!(params[:account_id])
        
        render json: { status: 'ok' }
    end
end