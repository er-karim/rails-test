class Person < ApplicationRecord
  include Updatable

  FIELDS_TO_CHECK_BEFORE_UPDATE = %I(email home_phone_number mobile_phone_number address).freeze

  validates :reference, :firstname, :lastname, :email, :mobile_phone_number, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :reference, uniqueness: true, numericality: { only_integer: true }
end
