require "application_system_test_case"

class RechargesTest < ApplicationSystemTestCase
  setup do
    @recharge = recharges(:one)
  end

  test "visiting the index" do
    visit recharges_url
    assert_selector "h1", text: "Recharges"
  end

  test "creating a Recharge" do
    visit recharges_url
    click_on "New Recharge"

    fill_in "Amount", with: @recharge.amount
    fill_in "Operator", with: @recharge.operator
    fill_in "User", with: @recharge.user_id
    click_on "Create Recharge"

    assert_text "Recharge was successfully created"
    click_on "Back"
  end

  test "updating a Recharge" do
    visit recharges_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @recharge.amount
    fill_in "Operator", with: @recharge.operator
    fill_in "User", with: @recharge.user_id
    click_on "Update Recharge"

    assert_text "Recharge was successfully updated"
    click_on "Back"
  end

  test "destroying a Recharge" do
    visit recharges_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recharge was successfully destroyed"
  end
end
