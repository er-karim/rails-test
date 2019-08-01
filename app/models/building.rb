class Building < ApplicationRecord
  include Updatable

  FIELDS_TO_CHECK_BEFORE_UPDATE = [:manager_name].freeze

  validates :manager_name, presence: true, length: {minimum: 2}
  validates :reference, presence: true, uniqueness: true, numericality: { only_integer: true }
end
