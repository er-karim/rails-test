class Building < ApplicationRecord
  validates :manager_name, presence: true, length: {minimum: 2}
end
