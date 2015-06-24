module HasOmiseCustomer
    extend ActiveSupport::Concern

    included do
        after_create :create_omise_customer_account

        def customer
            Omise::Customer.retrieve(omise_id)
        end
    end

    def create_omise_customer_account
        customer = Omise::Customer.create(
            email: email,
            description: name
        )
        self.update_column(:omise_id, customer.id)
    end
end