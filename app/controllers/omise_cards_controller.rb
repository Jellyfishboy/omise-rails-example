class OmiseCardsController < ApplicationController
    before_filter :authenticate_user!

    def create
        set_user
        @user.customer.cards.create(
            name: params[:name],
            number: params[:number],
            expiration_month: params[:expiration_month],
            expiration_year: params[:expiration_year],
            security_code: params[:security_code]
        )
        redirect_to user_path(@user.id)
    end

    def destroy
        set_user
        @user.customer.cards.retrieve(params[:card_token]).destroy
        redirect_to user_path(@user.id)
    end

    private

    def set_user
        @user ||= User.find(params[:user_id])
    end
end