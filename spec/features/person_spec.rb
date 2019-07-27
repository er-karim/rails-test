require 'rails_helper'

RSpec.feature "People", type: :feature, js: true do
  describe "people#index" do
    scenario "show list of people" do
      people = create_list(:person, 5, :random_person)

      visit people_path

      people.each do |person|
        expect(page).to have_content(person.reference)
      end
    end
  end

  describe "people#show" do
    scenario "display valid person page" do
      person = create(:person)

      visit person_path(person)

      expect(page).to have_content(person.reference)
    end
  end

  describe "people#update" do
    let!(:person) { create(:person) }

    scenario "update successfully with valid values" do
      random_person = build(:person, :random_person)

      visit edit_person_path(person)
      fill_form(random_person, 'Update Person')

      expect(page).to have_content('Person was successfully updated.')
      expect(page).to have_content(random_person.reference)
      expect(page).to have_content(random_person.email)
    end

    scenario "update failed with invalid values" do
      invalid_person = build(:person, reference: '', firstname: '', lastname: '', email: '', mobile_phone_number: '')

      visit edit_person_path(person)
      fill_form(invalid_person, 'Update Person')

      expect_validation_errors()
    end
  end

  describe "people#create" do
    scenario "success with valid values" do
      person = build(:person)

      visit new_person_path
      fill_form(person, 'Create Person')

      expect(page).to have_content('Person was successfully created.')
      expect(page).to have_content(person.reference)
      expect(page).to have_content(person.email)
    end

    scenario "failed with invalid values" do
      person = build(:person, reference: '', firstname: '', lastname: '', email: '', mobile_phone_number: '')

      visit new_person_path
      fill_form(person, 'Create Person')

      expect_validation_errors()
    end
  end

  describe "people#destroy" do
    scenario "deletes successfully" do
      person = create(:person)
      visit people_path

      delete_item()

      expect(page).to have_content("Person was successfully destroyed.")
    end
  end

  def fill_form(person, submit_button)
    fill_in 'Reference', with: person.reference
    fill_in 'Email', with: person.email
    fill_in 'Firstname', with: person.firstname
    fill_in 'Lastname', with: person.lastname
    fill_in 'Home phone number', with: person.home_phone_number
    fill_in 'Mobile phone number', with: person.mobile_phone_number
    fill_in 'Address', with: person.address
    click_button submit_button
  end

  def expect_validation_errors
    expect(page).to have_content("Reference can't be blank")
    expect(page).to have_content("Reference is not a number")
    expect(page).to have_content("Firstname can't be blank")
    expect(page).to have_content("Lastname can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Mobile phone number can't be blank")
  end
end