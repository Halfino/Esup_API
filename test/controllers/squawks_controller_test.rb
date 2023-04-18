require "test_helper"

class SquawksControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get squawks_create_url
    assert_response :success
  end
end
