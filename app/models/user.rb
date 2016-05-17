class User < ActiveRecord::Base
  class << self
    def create_from_omniauth(params)
      attributes = {
        email: params['info']['email'],
        password: Devise.friendly_token
      }

      create(attributes)
    end

    def find_by_mondo_id(id)
      joins(authentications: :authentication_provider)
        .find_by(
          user_authentications: { uid: id },
          authentication_providers: { name: 'mondo' })
    end
  end

  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  has_many :authentication_providers, through: :authentications, as: :providers
  has_many :transactions
  devise :omniauthable, :database_authenticatable, :registerable, :trackable, :validatable, omniauth_providers: [:mondo, :foursquare]
  store :categories, accessors: Merchant::CATEGORIES

  after_create :setup_categories

  def mondo
    find_authentication 'mondo'
  end

  def foursquare
    find_authentication 'foursquare'
  end

  def fully_registered?
    mondo.present? && foursquare.present?
  end

  def recent_transactions(n = 5)
    transactions.order(:created_at).limit(n)
  end

  private

  def setup_categories
    Merchant::CATEGORIES.each { |cat| update_attribute cat, 1 }
  end

  def find_authentication(name)
    authentications.joins(:authentication_provider).find_by(authentication_providers: { name: name })
  end
end
