require "test_helper"

class SystemConfigurationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @system_configuration = system_configurations(:one)
  end

  test "should get index" do
    get system_configurations_url
    assert_response :success
  end

  test "should get new" do
    get new_system_configuration_url
    assert_response :success
  end

  test "should create system_configuration" do
    assert_difference('SystemConfiguration.count') do
      post system_configurations_url, params: { system_configuration: { cantv: @system_configuration.cantv, digitel: @system_configuration.digitel, dolar_bcv: @system_configuration.dolar_bcv, inter: @system_configuration.inter, movilnet: @system_configuration.movilnet, movistar: @system_configuration.movistar, movistar_tv: @system_configuration.movistar_tv, simple_tv: @system_configuration.simple_tv } }
    end

    assert_redirected_to system_configuration_url(SystemConfiguration.last)
  end

  test "should show system_configuration" do
    get system_configuration_url(@system_configuration)
    assert_response :success
  end

  test "should get edit" do
    get edit_system_configuration_url(@system_configuration)
    assert_response :success
  end

  test "should update system_configuration" do
    patch system_configuration_url(@system_configuration), params: { system_configuration: { cantv: @system_configuration.cantv, digitel: @system_configuration.digitel, dolar_bcv: @system_configuration.dolar_bcv, inter: @system_configuration.inter, movilnet: @system_configuration.movilnet, movistar: @system_configuration.movistar, movistar_tv: @system_configuration.movistar_tv, simple_tv: @system_configuration.simple_tv } }
    assert_redirected_to system_configuration_url(@system_configuration)
  end

  test "should destroy system_configuration" do
    assert_difference('SystemConfiguration.count', -1) do
      delete system_configuration_url(@system_configuration)
    end

    assert_redirected_to system_configurations_url
  end
end
