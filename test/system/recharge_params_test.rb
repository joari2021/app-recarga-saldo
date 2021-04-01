require "application_system_test_case"

class RechargeParamsTest < ApplicationSystemTestCase
  setup do
    @recharge_param = recharge_params(:one)
  end

  test "visiting the index" do
    visit recharge_params_url
    assert_selector "h1", text: "Recharge Params"
  end

  test "creating a Recharge param" do
    visit recharge_params_url
    click_on "New Recharge Param"

    fill_in "Amount max", with: @recharge_param.amount_max
    fill_in "Amount min", with: @recharge_param.amount_min
    fill_in "Multiplos amount permit", with: @recharge_param.multiplos_amount_permit
    fill_in "Operadora", with: @recharge_param.operadora
    click_on "Create Recharge param"

    assert_text "Recharge param was successfully created"
    click_on "Back"
  end

  test "updating a Recharge param" do
    visit recharge_params_url
    click_on "Edit", match: :first

    fill_in "Amount max", with: @recharge_param.amount_max
    fill_in "Amount min", with: @recharge_param.amount_min
    fill_in "Multiplos amount permit", with: @recharge_param.multiplos_amount_permit
    fill_in "Operadora", with: @recharge_param.operadora
    click_on "Update Recharge param"

    assert_text "Recharge param was successfully updated"
    click_on "Back"
  end

  test "destroying a Recharge param" do
    visit recharge_params_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recharge param was successfully destroyed"
  end
end
