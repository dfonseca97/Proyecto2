require 'test_helper'

class EventControllerTest < ActionDispatch::IntegrationTest
  test "should get get_location" do
    get event_get_location_url
    assert_response :success
  end

end
