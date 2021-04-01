require "application_system_test_case"

class BalaceInquiriesTest < ApplicationSystemTestCase
  setup do
    @balace_inquiry = balace_inquiries(:one)
  end

  test "visiting the index" do
    visit balace_inquiries_url
    assert_selector "h1", text: "Balace Inquiries"
  end

  test "creating a Balace inquiry" do
    visit balace_inquiries_url
    click_on "New Balace Inquiry"

    fill_in "Avalaible days", with: @balace_inquiry.avalaible_days
    fill_in "Debt", with: @balace_inquiry.debt
    fill_in "Operadora", with: @balace_inquiry.operadora
    fill_in "Status", with: @balace_inquiry.status
    click_on "Create Balace inquiry"

    assert_text "Balace inquiry was successfully created"
    click_on "Back"
  end

  test "updating a Balace inquiry" do
    visit balace_inquiries_url
    click_on "Edit", match: :first

    fill_in "Avalaible days", with: @balace_inquiry.avalaible_days
    fill_in "Debt", with: @balace_inquiry.debt
    fill_in "Operadora", with: @balace_inquiry.operadora
    fill_in "Status", with: @balace_inquiry.status
    click_on "Update Balace inquiry"

    assert_text "Balace inquiry was successfully updated"
    click_on "Back"
  end

  test "destroying a Balace inquiry" do
    visit balace_inquiries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Balace inquiry was successfully destroyed"
  end
end
