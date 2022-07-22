require "application_system_test_case"

class LoyaltyProgramDataTest < ApplicationSystemTestCase
  setup do
    @loyalty_program_datum = loyalty_program_data(:one)
  end

  test "visiting the index" do
    visit loyalty_program_data_url
    assert_selector "h1", text: "Loyalty program data"
  end

  test "should create loyalty program datum" do
    visit loyalty_program_data_url
    click_on "New loyalty program datum"

    fill_in "Loyalty program", with: @loyalty_program_datum.loyalty_program_id
    fill_in "Points", with: @loyalty_program_datum.points
    fill_in "Transaction history", with: @loyalty_program_datum.transaction_history
    click_on "Create Loyalty program datum"

    assert_text "Loyalty program datum was successfully created"
    click_on "Back"
  end

  test "should update Loyalty program datum" do
    visit loyalty_program_datum_url(@loyalty_program_datum)
    click_on "Edit this loyalty program datum", match: :first

    fill_in "Loyalty program", with: @loyalty_program_datum.loyalty_program_id
    fill_in "Points", with: @loyalty_program_datum.points
    fill_in "Transaction history", with: @loyalty_program_datum.transaction_history
    click_on "Update Loyalty program datum"

    assert_text "Loyalty program datum was successfully updated"
    click_on "Back"
  end

  test "should destroy Loyalty program datum" do
    visit loyalty_program_datum_url(@loyalty_program_datum)
    click_on "Destroy this loyalty program datum", match: :first

    assert_text "Loyalty program datum was successfully destroyed"
  end
end
