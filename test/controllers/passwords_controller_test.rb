require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get passwords_index_url
    assert_response :success
  end

  test "should get show" do
    get passwords_show_url
    assert_response :success
  end

  test "should get new" do
    get passwords_new_url
    assert_response :success
  end

  test "should get edit" do
    get passwords_edit_url
    assert_response :success
  end
end
