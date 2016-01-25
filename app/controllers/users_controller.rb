class UsersController < ApplicationController
    before_filter :authenticate_user!

    def index
        set_users
    end

    def show
        set_user
        new_card
    end
    
    private

    def set_users
        @users ||= User.all
    end

    def new_card
        @card ||= Card.new
    end

    def set_user
        @user ||= User.find(params[:id])
    end
end