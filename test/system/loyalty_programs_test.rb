require "application_system_test_case"

class LoyaltyProgramsTest < ApplicationSystemTestCase
  setup do
    @loyalty_program = loyalty_programs(:one)
  end

  test "visiting the index" do
    visit loyalty_programs_url
    assert_selector "h1", text: "Loyalty programs"
  end

  test "should create loyalty program" do
    visit loyalty_programs_url
    click_on "New loyalty program"

    fill_in "Currency name", with: @loyalty_program.currency_name
    fill_in "Description", with: @loyalty_program.description
    fill_in "Enrollment link", with: @loyalty_program.enrollment_link
    fill_in "Loyalty program", with: @loyalty_program.loyalty_program_id
    fill_in "Processing time", with: @loyalty_program.processing_time
    fill_in "Program name", with: @loyalty_program.program_name
    fill_in "Terms and conditions link", with: @loyalty_program.terms_and_conditions_link
    click_on "Create Loyalty program"

    assert_text "Loyalty program was successfully created"
    click_on "Back"
  end

  test "should update Loyalty program" do
    visit loyalty_program_url(@loyalty_program)
    click_on "Edit this loyalty program", match: :first

    fill_in "Currency name", with: @loyalty_program.currency_name
    fill_in "Description", with: @loyalty_program.description
    fill_in "Enrollment link", with: @loyalty_program.enrollment_link
    fill_in "Loyalty program", with: @loyalty_program.loyalty_program_id
    fill_in "Processing time", with: @loyalty_program.processing_time
    fill_in "Program name", with: @loyalty_program.program_name
    fill_in "Terms and conditions link", with: @loyalty_program.terms_and_conditions_link
    click_on "Update Loyalty program"

    assert_text "Loyalty program was successfully updated"
    click_on "Back"
  end

  test "should destroy Loyalty program" do
    visit loyalty_program_url(@loyalty_program)
    click_on "Destroy this loyalty program", match: :first

    assert_text "Loyalty program was successfully destroyed"
  end
end
