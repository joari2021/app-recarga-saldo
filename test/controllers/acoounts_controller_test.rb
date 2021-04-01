require "test_helper"

class AcoountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @acoount = acoounts(:one)
  end

  test "should get index" do
    get acoounts_url
    assert_response :success
  end

  test "should get new" do
    get new_acoount_url
    assert_response :success
  end

  test "should create acoount" do
    assert_difference('Acoount.count') do
      post acoounts_url, params: { acoount: { bank: @acoount.bank, document: @acoount.document, number_account: @acoount.number_account, phone: @acoount.phone, type_document: @acoount.type_document, user_id: @acoount.user_id } }
    end

    assert_redirected_to acoount_url(Acoount.last)
  end

  test "should show acoount" do
    get acoount_url(@acoount)
    assert_response :success
  end

  test "should get edit" do
    get edit_acoount_url(@acoount)
    assert_response :success
  end

  test "should update acoount" do
    patch acoount_url(@acoount), params: { acoount: { bank: @acoount.bank, document: @acoount.document, number_account: @acoount.number_account, phone: @acoount.phone, type_document: @acoount.type_document, user_id: @acoount.user_id } }
    assert_redirected_to acoount_url(@acoount)
  end

  test "should destroy acoount" do
    assert_difference('Acoount.count', -1) do
      delete acoount_url(@acoount)
    end

    assert_redirected_to acoounts_url
  end
end
