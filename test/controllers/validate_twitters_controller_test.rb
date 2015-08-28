require 'test_helper'

class ValidateTwittersControllerTest < ActionController::TestCase
  setup do
    @validate_twitter = validate_twitters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:validate_twitters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create validate_twitter" do
    assert_difference('ValidateTwitter.count') do
      post :create, validate_twitter: {  }
    end

    assert_redirected_to validate_twitter_path(assigns(:validate_twitter))
  end

  test "should show validate_twitter" do
    get :show, id: @validate_twitter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @validate_twitter
    assert_response :success
  end

  test "should update validate_twitter" do
    patch :update, id: @validate_twitter, validate_twitter: {  }
    assert_redirected_to validate_twitter_path(assigns(:validate_twitter))
  end

  test "should destroy validate_twitter" do
    assert_difference('ValidateTwitter.count', -1) do
      delete :destroy, id: @validate_twitter
    end

    assert_redirected_to validate_twitters_path
  end
end
