class User < ActiveRecord::Base
    include HasOmiseCustomer

    devise :database_authenticatable, :rememberable, :trackable, :validatable
end
