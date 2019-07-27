class Building < ApplicationRecord
  validates :manager_name, presence: true, length: {minimum: 2}
  validates :reference, presence: true, uniqueness: true, numericality: { only_integer: true }
end
