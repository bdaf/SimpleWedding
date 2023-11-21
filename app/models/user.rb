class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 50}, format: { with: ConstantData::VALID_EMAIL_REGEX, :multiline => true }
    normalizes :email, with: -> (email) {email.downcase}

    validates :name, presence: true , length: { maximum: 50 }
    normalizes :name, with: -> (name) {name.capitalize}

    validates :surname, presence: true , length: { maximum: 80 }
    normalizes :surname, with: -> (surname) {surname.capitalize}

    validates :city, presence: true , length: { maximum: 50 }
    normalizes :city, with: -> (city) {city.capitalize}

    validates :phone_number, presence: true , length: { maximum: 12 }
    validates :celebration_date, presence: true

    generates_token_for :password_reset, expires_in: 15.minutes do
        password_salt&.last(10)
    end

    # Todo later email confirmation:
    # generates_token_for :email_confirmation, expires_in: 24.hours do
    #     email
    # end
    
end
