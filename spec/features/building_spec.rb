require 'rails_helper'

RSpec.feature "Buildings", type: :feature, js: true do
  describe "buildings#index" do
    scenario "show list of buildings" do
      buildings = create_list(:building, 5, :random_building)

      visit buildings_path

      buildings.each do |building|
        expect(page).to have_content(building.reference)
      end
    end
  end

  describe "buildings#show" do
    scenario "display valid building page" do
      building = create(:building)

      visit building_path(building)

      expect(page).to have_content(building.reference)
    end
  end

  describe "buildings#update" do
    let!(:building) { create(:building) }

    scenario "update successfully with valid values" do
      random_building = build(:building, :random_building)

      visit edit_building_path(building)
      fill_form(random_building, 'Update Building')

      expect(page).to have_content('Building was successfully updated.')
      expect(page).to have_content(random_building.manager_name)
      expect(page).to have_content(random_building.reference)
    end

    scenario "update failed with invalid values" do
      invalid_building = build(:building, manager_name: '', reference: '')

      visit edit_building_path(building)
      fill_form(invalid_building, 'Update Building')

      expect_validation_errors()
    end
  end

  describe "buildings#create" do
    scenario "success with valid values" do
      building = build(:building)

      visit new_building_path
      fill_form(building, 'Create Building')

      expect(page).to have_content('Building was successfully created.')
      expect(page).to have_content(building.manager_name)
      expect(page).to have_content(building.reference)
    end

    scenario "failed with invalid values" do
      building = build(:building, manager_name: '', reference: '')

      visit new_building_path
      fill_form(building, 'Create Building')

      expect_validation_errors()
    end
  end

  describe "buildings#destroy" do
    scenario "deletes successfully" do
      building = create(:building)
      visit buildings_path

      delete_item()

      expect(page).to have_content("Building was successfully destroyed.")
    end
  end

  def fill_form(building, submit_button)
    fill_in 'Reference', with: building.reference
    fill_in 'Address', with: building.address
    fill_in 'Zip code', with: building.zip_code
    fill_in 'City', with: building.city
    fill_in 'Country', with: building.country
    fill_in 'Manager name', with: building.manager_name
    click_button submit_button
  end

  def expect_validation_errors
    expect(page).to have_content("Manager name can't be blank")
    expect(page).to have_content("Manager name is too short (minimum is 2 characters)")
    expect(page).to have_content("Reference can't be blank")
    expect(page).to have_content("Reference is not a number")
  end
end