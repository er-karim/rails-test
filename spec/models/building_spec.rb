require 'rails_helper'
require 'shared/examples/models'

RSpec.describe Building, type: :model do
  describe "Validations" do
    include_examples 'presence validations', %i[manager_name reference]
    it { should validate_length_of(:manager_name).is_at_least(2) }
    it { should validate_uniqueness_of(:reference) }
    it { should validate_numericality_of(:reference).only_integer }
  end
end