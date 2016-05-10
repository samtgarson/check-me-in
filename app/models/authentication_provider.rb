class AuthenticationProvider < ActiveRecord::Base
  has_many :users, inverse_of: :provider
  has_many :user_authentications
end
