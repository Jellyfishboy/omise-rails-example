class OmiseCardsController < ApplicationController
    before_filter :authenticate_user!

    def create
        set_user
        @card = @user.customer.update(card: params[:token]) 
        card_array = @card.attributes["cards"]["data"]
        render json: { first: @user.customer.cards == 1 ? true : false, card: render_to_string(partial: 'omise_cards/single', locals: { card: OpenStruct.new(card_array[card_array.length-1]) }) }, status: 200
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
        charge_card
        if @charge.authorized
            # successful charge to the card
            redirect_to user_path(@user.id)
        else
            # failed charge to the card
            redirect_to root_path
        end
    end

    private

    def set_user
        @user ||= User.find(params[:user_id])
    end

    def set_card
        @card ||= @user.customer.cards.retrieve(params[:id])
    end

    def charge_card
        @charge = Omise::Charge.create(amount: (params[:value].to_i*100).round, currency: 'thb', card: params[:id], customer: @user.omise_id)
    end

    def card_params
        params.require(:card).permit(:name, :number, :expiration_month, :expiration_year, :security_code)
    end
end