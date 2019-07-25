class Person < ApplicationRecord
  validates :firstname, :lastname, :email, :mobile_phone_number, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
