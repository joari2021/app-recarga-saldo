require "application_system_test_case"

class NonexistentNumbersTest < ApplicationSystemTestCase
  setup do
    @nonexistent_number = nonexistent_numbers(:one)
  end

  test "visiting the index" do
    visit nonexistent_numbers_url
    assert_selector "h1", text: "Nonexistent Numbers"
  end

  test "creating a Nonexistent number" do
    visit nonexistent_numbers_url
    click_on "New Nonexistent Number"

    fill_in "Number", with: @nonexistent_number.number
    fill_in "Operator", with: @nonexistent_number.operator
    fill_in "Type payment", with: @nonexistent_number.type_payment
    click_on "Create Nonexistent number"

    assert_text "Nonexistent number was successfully created"
    click_on "Back"
  end

  test "updating a Nonexistent number" do
    visit nonexistent_numbers_url
    click_on "Edit", match: :first

    fill_in "Number", with: @nonexistent_number.number
    fill_in "Operator", with: @nonexistent_number.operator
    fill_in "Type payment", with: @nonexistent_number.type_payment
    click_on "Update Nonexistent number"

    assert_text "Nonexistent number was successfully updated"
    click_on "Back"
  end

  test "destroying a Nonexistent number" do
    visit nonexistent_numbers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Nonexistent number was successfully destroyed"
  end
end
