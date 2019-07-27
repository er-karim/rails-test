class Person < ApplicationRecord
  validates :reference, :firstname, :lastname, :email, :mobile_phone_number, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :reference, uniqueness: true, numericality: { only_integer: true }
end
