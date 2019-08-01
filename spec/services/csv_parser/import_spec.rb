require 'rails_helper'

describe CsvParser::Import do
  context ".call" do
    let!(:people_list) { create_list(:person, 200, :random_person) }
    let!(:person_file) { Rails.root.join('app/resources/person.test.csv') }

    it "updates records from csv, returns number of updated records and creates updates" do
      updates_before_count = Update.count

      expect(CsvParser::Import.call(file: person_file, model: Person)).not_to eq(0)

      expect(Update.count).not_to eq(updates_before_count)
    end

    it "returns INVALID_INPUTS when invalid inputs" do
      expect(CsvParser::Import.call(file: '', model: nil)).to eq(CsvParser::Import::INVALID_INPUTS)
    end

    it "returns EMPTY_UPDATE_LIST when ther is no updates" do
      expect(CsvParser::Import.call(file: person_file, model: Person)).to eq(CsvParser::Import::EMPTY_UPDATE_LIST)
    end
  end
end