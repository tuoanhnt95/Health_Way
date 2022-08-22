require "test_helper"

class SetUpsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get set_ups_index_url
    assert_response :success
  end

  test "should get show" do
    get set_ups_show_url
    assert_response :success
  end
end
