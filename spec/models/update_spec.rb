require 'rails_helper'
require 'shared/examples/models'

RSpec.describe Update, type: :model do
  describe "Validations" do
    include_examples 'presence validations', %i[field value]
    it { should validate_uniqueness_of(:field).scoped_to([:value, :updatable_type, :updatable_id]).case_insensitive }
    it { should have_db_column(:updatable_id).of_type(:integer) }
    it { should have_db_column(:updatable_type).of_type(:string) }
    it { should belong_to(:updatable) }
  end
end
