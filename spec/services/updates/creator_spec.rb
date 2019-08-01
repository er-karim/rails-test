require 'rails_helper'

describe Updates::Creator do
  context ".call" do
    let!(:person) { create(:person) }
    let!(:person_updates) do
      [
        create(:update, :with_person, updatable: person),
        create(:update, :with_person, updatable: person, field: 'home_phone_number', value: '0511111111'),
        create(:update, :with_person, updatable: person, field: 'mobile_phone_number', value: '0622222222'),
        create(:update, :with_person, updatable: person, field: 'address', value: 'address')
      ] 
    end

    it "returns false when we don't have new updates" do
      expect(Updates::Creator.call(model: Person, record_id: person.id)).to be_falsy
    end

    it "inserts only updated fields from model attributes with update rules" do
      person.update(home_phone_number: '0522222222', mobile_phone_number: '0611111111')

      # expect 2 inserts
      expect(Updates::Creator.call(model: Person, record_id: person.id)).to eq(2)
    end
  end
end