require "test_helper"

class LoyaltyProgramDataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loyalty_program_datum = loyalty_program_data(:one)
  end

  test "should get index" do
    get loyalty_program_data_url
    assert_response :success
  end

  test "should get new" do
    get new_loyalty_program_datum_url
    assert_response :success
  end

  test "should create loyalty_program_datum" do
    assert_difference("LoyaltyProgramDatum.count") do
      post loyalty_program_data_url, params: { loyalty_program_datum: { loyalty_program_id: @loyalty_program_datum.loyalty_program_id, points: @loyalty_program_datum.points, transaction_history: @loyalty_program_datum.transaction_history } }
    end

    assert_redirected_to loyalty_program_datum_url(LoyaltyProgramDatum.last)
  end

  test "should show loyalty_program_datum" do
    get loyalty_program_datum_url(@loyalty_program_datum)
    assert_response :success
  end

  test "should get edit" do
    get edit_loyalty_program_datum_url(@loyalty_program_datum)
    assert_response :success
  end

  test "should update loyalty_program_datum" do
    patch loyalty_program_datum_url(@loyalty_program_datum), params: { loyalty_program_datum: { loyalty_program_id: @loyalty_program_datum.loyalty_program_id, points: @loyalty_program_datum.points, transaction_history: @loyalty_program_datum.transaction_history } }
    assert_redirected_to loyalty_program_datum_url(@loyalty_program_datum)
  end

  test "should destroy loyalty_program_datum" do
    assert_difference("LoyaltyProgramDatum.count", -1) do
      delete loyalty_program_datum_url(@loyalty_program_datum)
    end

    assert_redirected_to loyalty_program_data_url
  end
end
