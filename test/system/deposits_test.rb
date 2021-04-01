require "application_system_test_case"

class DepositsTest < ApplicationSystemTestCase
  setup do
    @deposit = deposits(:one)
  end

  test "visiting the index" do
    visit deposits_url
    assert_selector "h1", text: "Deposits"
  end

  test "creating a Deposit" do
    visit deposits_url
    click_on "New Deposit"

    fill_in "Amount", with: @deposit.amount
    fill_in "Bank origin", with: @deposit.bank_origin
    fill_in "Phone", with: @deposit.phone
    fill_in "Status", with: @deposit.status
    fill_in "User", with: @deposit.user_id
    click_on "Create Deposit"

    assert_text "Deposit was successfully created"
    click_on "Back"
  end

  test "updating a Deposit" do
    visit deposits_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @deposit.amount
    fill_in "Bank origin", with: @deposit.bank_origin
    fill_in "Phone", with: @deposit.phone
    fill_in "Status", with: @deposit.status
    fill_in "User", with: @deposit.user_id
    click_on "Update Deposit"

    assert_text "Deposit was successfully updated"
    click_on "Back"
  end

  test "destroying a Deposit" do
    visit deposits_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Deposit was successfully destroyed"
  end
end
