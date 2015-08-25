require 'test_helper'

class PlayControllerTest < ActionController::TestCase
  test "should get product" do
    get :product
    assert_response :success
  end

end
