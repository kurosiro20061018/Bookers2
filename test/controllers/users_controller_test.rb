require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get shoe" do
    get users_shoe_url
    assert_response :success
  end

  test "should get edid" do
    get users_edid_url
    assert_response :success
  end
end
