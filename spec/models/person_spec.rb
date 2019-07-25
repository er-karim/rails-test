require 'rails_helper'

RSpec.describe Person, type: :model do
  describe "Validations" do    
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value("test@example.dev").for(:email) }
    it { should_not allow_value("test").for(:email) }
    it { should validate_presence_of(:mobile_phone_number) }
  end
end
