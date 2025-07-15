require "test_helper"

class ParticipationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get participation_index_url
    assert_response :success
  end

  test "should get new" do
    get participation_new_url
    assert_response :success
  end

  test "should get create" do
    get participation_create_url
    assert_response :success
  end

  test "should get edit" do
    get participation_edit_url
    assert_response :success
  end

  test "should get update" do
    get participation_update_url
    assert_response :success
  end
end

test "index should respond successfully" do
  get participation_index_url
  assert_response :success
end

test "index should render the index template" do
  get participation_index_url
  assert_template :index
end
