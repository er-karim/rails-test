class Update < ApplicationRecord
  belongs_to :updatable, polymorphic: true
  validates :field, :value, presence: true
  validates :field, uniqueness: { scope: [:value, :updatable_type, :updatable_id], case_sensitive: false }

  def self.not_exists?(params)
    where(params).empty?
  end
end
