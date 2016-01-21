class OmiseCardsController < ApplicationController
    before_filter :authenticate_user!

    def new
        set_user
        new_card
    end

    def create
        set_user
        @card = Card.new(card_params)
        if @card.valid?
            @user.customer.cards.create(card_params)
            redirect_to user_path(@user.id)
        else
            render :new
        end
    end

    def destroy
        set_user
        set_card
        @card.destroy
        redirect_to user_path(@user.id)
    end

    def charge
        set_user
        set_card
    end

    private

    def set_user
        @user ||= User.find(params[:user_id])
    end

    def set_card
        @card ||= @user.customer.cards.retrieve(params[:id])
    end

    def new_card
        @card = Card.new
    end

    def card_params
        params.require(:card).permit(:name, :number, :expiration_month, :expiration_year, :security_code)
    end
end