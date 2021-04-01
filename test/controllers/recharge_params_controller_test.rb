require "test_helper"

class RechargeParamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recharge_param = recharge_params(:one)
  end

  test "should get index" do
    get recharge_params_url
    assert_response :success
  end

  test "should get new" do
    get new_recharge_param_url
    assert_response :success
  end

  test "should create recharge_param" do
    assert_difference('RechargeParam.count') do
      post recharge_params_url, params: { recharge_param: { amount_max: @recharge_param.amount_max, amount_min: @recharge_param.amount_min, multiplos_amount_permit: @recharge_param.multiplos_amount_permit, operadora: @recharge_param.operadora } }
    end

    assert_redirected_to recharge_param_url(RechargeParam.last)
  end

  test "should show recharge_param" do
    get recharge_param_url(@recharge_param)
    assert_response :success
  end

  test "should get edit" do
    get edit_recharge_param_url(@recharge_param)
    assert_response :success
  end

  test "should update recharge_param" do
    patch recharge_param_url(@recharge_param), params: { recharge_param: { amount_max: @recharge_param.amount_max, amount_min: @recharge_param.amount_min, multiplos_amount_permit: @recharge_param.multiplos_amount_permit, operadora: @recharge_param.operadora } }
    assert_redirected_to recharge_param_url(@recharge_param)
  end

  test "should destroy recharge_param" do
    assert_difference('RechargeParam.count', -1) do
      delete recharge_param_url(@recharge_param)
    end

    assert_redirected_to recharge_params_url
  end
end
