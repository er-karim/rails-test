require 'rails_helper'
require 'shared/examples/models'

RSpec.describe Person, type: :model do
  describe "Validations" do
    include_examples 'presence validations', %i[reference firstname lastname email mobile_phone_number]
    include_examples 'uniqueness validations', %i[reference email]
    it { should validate_numericality_of(:reference).only_integer }
    it { should allow_value("test@example.dev").for(:email) }
    it { should_not allow_value("test").for(:email) }
  end
end
