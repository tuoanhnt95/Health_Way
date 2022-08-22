require "test_helper"

class HealthChecksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get health_checks_index_url
    assert_response :success
  end

  test "should get show" do
    get health_checks_show_url
    assert_response :success
  end

  test "should get new" do
    get health_checks_new_url
    assert_response :success
  end

  test "should get edit" do
    get health_checks_edit_url
    assert_response :success
  end
end
