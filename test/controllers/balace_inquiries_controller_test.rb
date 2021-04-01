require "test_helper"

class BalaceInquiriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @balace_inquiry = balace_inquiries(:one)
  end

  test "should get index" do
    get balace_inquiries_url
    assert_response :success
  end

  test "should get new" do
    get new_balace_inquiry_url
    assert_response :success
  end

  test "should create balace_inquiry" do
    assert_difference('BalaceInquiry.count') do
      post balace_inquiries_url, params: { balace_inquiry: { avalaible_days: @balace_inquiry.avalaible_days, debt: @balace_inquiry.debt, operadora: @balace_inquiry.operadora, status: @balace_inquiry.status } }
    end

    assert_redirected_to balace_inquiry_url(BalaceInquiry.last)
  end

  test "should show balace_inquiry" do
    get balace_inquiry_url(@balace_inquiry)
    assert_response :success
  end

  test "should get edit" do
    get edit_balace_inquiry_url(@balace_inquiry)
    assert_response :success
  end

  test "should update balace_inquiry" do
    patch balace_inquiry_url(@balace_inquiry), params: { balace_inquiry: { avalaible_days: @balace_inquiry.avalaible_days, debt: @balace_inquiry.debt, operadora: @balace_inquiry.operadora, status: @balace_inquiry.status } }
    assert_redirected_to balace_inquiry_url(@balace_inquiry)
  end

  test "should destroy balace_inquiry" do
    assert_difference('BalaceInquiry.count', -1) do
      delete balace_inquiry_url(@balace_inquiry)
    end

    assert_redirected_to balace_inquiries_url
  end
end
