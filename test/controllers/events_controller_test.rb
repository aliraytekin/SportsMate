require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get events_index_url
    assert_response :success
  end

  test "should get new" do
    get events_new_url
    assert_response :success
  end

  test "should get create" do
    get events_create_url
    assert_response :success
  end

  test "should get edit" do
    get events_edit_url
    assert_response :success
  end

  test "should get update" do
    get events_update_url
    assert_response :success
  end

  test "should get destroy" do
    get events_destroy_url
    assert_response :success
  end

  test "should get cancel" do
    get events_cancel_url
    assert_response :success
  end

  test "should get payment" do
    get events_payment_url
    assert_response :success
  end

  test "should get success" do
    get events_success_url
    assert_response :success
  end

  test "should get confirmation" do
    get events_confirmation_url
    assert_response :success
  end
end
