require 'rails_helper'

RSpec.describe Building, type: :model do
  describe "Validations" do    
    it { should validate_presence_of(:manager_name) }
    it { should validate_length_of(:manager_name).is_at_least(2) }
  end
end