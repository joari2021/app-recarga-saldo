require "application_system_test_case"

class AcoountsTest < ApplicationSystemTestCase
  setup do
    @acoount = acoounts(:one)
  end

  test "visiting the index" do
    visit acoounts_url
    assert_selector "h1", text: "Acoounts"
  end

  test "creating a Acoount" do
    visit acoounts_url
    click_on "New Acoount"

    fill_in "Bank", with: @acoount.bank
    fill_in "Document", with: @acoount.document
    fill_in "Number account", with: @acoount.number_account
    fill_in "Phone", with: @acoount.phone
    fill_in "Type document", with: @acoount.type_document
    fill_in "User", with: @acoount.user_id
    click_on "Create Acoount"

    assert_text "Acoount was successfully created"
    click_on "Back"
  end

  test "updating a Acoount" do
    visit acoounts_url
    click_on "Edit", match: :first

    fill_in "Bank", with: @acoount.bank
    fill_in "Document", with: @acoount.document
    fill_in "Number account", with: @acoount.number_account
    fill_in "Phone", with: @acoount.phone
    fill_in "Type document", with: @acoount.type_document
    fill_in "User", with: @acoount.user_id
    click_on "Update Acoount"

    assert_text "Acoount was successfully updated"
    click_on "Back"
  end

  test "destroying a Acoount" do
    visit acoounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Acoount was successfully destroyed"
  end
end
