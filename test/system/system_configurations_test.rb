require "application_system_test_case"

class SystemConfigurationsTest < ApplicationSystemTestCase
  setup do
    @system_configuration = system_configurations(:one)
  end

  test "visiting the index" do
    visit system_configurations_url
    assert_selector "h1", text: "System Configurations"
  end

  test "creating a System configuration" do
    visit system_configurations_url
    click_on "New System Configuration"

    check "Cantv" if @system_configuration.cantv
    check "Digitel" if @system_configuration.digitel
    fill_in "Dolar bcv", with: @system_configuration.dolar_bcv
    check "Inter" if @system_configuration.inter
    check "Movilnet" if @system_configuration.movilnet
    check "Movistar" if @system_configuration.movistar
    check "Movistar tv" if @system_configuration.movistar_tv
    check "Simple tv" if @system_configuration.simple_tv
    click_on "Create System configuration"

    assert_text "System configuration was successfully created"
    click_on "Back"
  end

  test "updating a System configuration" do
    visit system_configurations_url
    click_on "Edit", match: :first

    check "Cantv" if @system_configuration.cantv
    check "Digitel" if @system_configuration.digitel
    fill_in "Dolar bcv", with: @system_configuration.dolar_bcv
    check "Inter" if @system_configuration.inter
    check "Movilnet" if @system_configuration.movilnet
    check "Movistar" if @system_configuration.movistar
    check "Movistar tv" if @system_configuration.movistar_tv
    check "Simple tv" if @system_configuration.simple_tv
    click_on "Update System configuration"

    assert_text "System configuration was successfully updated"
    click_on "Back"
  end

  test "destroying a System configuration" do
    visit system_configurations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "System configuration was successfully destroyed"
  end
end
