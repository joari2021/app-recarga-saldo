require "test_helper"

class NonexistentNumbersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nonexistent_number = nonexistent_numbers(:one)
  end

  test "should get index" do
    get nonexistent_numbers_url
    assert_response :success
  end

  test "should get new" do
    get new_nonexistent_number_url
    assert_response :success
  end

  test "should create nonexistent_number" do
    assert_difference('NonexistentNumber.count') do
      post nonexistent_numbers_url, params: { nonexistent_number: { number: @nonexistent_number.number, operator: @nonexistent_number.operator, type_payment: @nonexistent_number.type_payment } }
    end

    assert_redirected_to nonexistent_number_url(NonexistentNumber.last)
  end

  test "should show nonexistent_number" do
    get nonexistent_number_url(@nonexistent_number)
    assert_response :success
  end

  test "should get edit" do
    get edit_nonexistent_number_url(@nonexistent_number)
    assert_response :success
  end

  test "should update nonexistent_number" do
    patch nonexistent_number_url(@nonexistent_number), params: { nonexistent_number: { number: @nonexistent_number.number, operator: @nonexistent_number.operator, type_payment: @nonexistent_number.type_payment } }
    assert_redirected_to nonexistent_number_url(@nonexistent_number)
  end

  test "should destroy nonexistent_number" do
    assert_difference('NonexistentNumber.count', -1) do
      delete nonexistent_number_url(@nonexistent_number)
    end

    assert_redirected_to nonexistent_numbers_url
  end
end
