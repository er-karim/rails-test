RSpec.shared_examples 'presence validations' do |fields|
  fields.each do |field|
    it { should validate_presence_of(field) }
  end
end

RSpec.shared_examples 'uniqueness validations' do |fields|
  fields.each do |field|
    it { should validate_uniqueness_of(field) }
  end
end