require 'test_helper'

class ValidateFacebooksControllerTest < ActionController::TestCase
  setup do
    @validate_facebook = validate_facebooks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:validate_facebooks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create validate_facebook" do
    assert_difference('ValidateFacebook.count') do
      post :create, validate_facebook: { before: @validate_facebook.before, time: @validate_facebook.time, uid: @validate_facebook.uid, url: @validate_facebook.url, url_id: @validate_facebook.url_id }
    end

    assert_redirected_to validate_facebook_path(assigns(:validate_facebook))
  end

  test "should show validate_facebook" do
    get :show, id: @validate_facebook
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @validate_facebook
    assert_response :success
  end

  test "should update validate_facebook" do
    patch :update, id: @validate_facebook, validate_facebook: { before: @validate_facebook.before, time: @validate_facebook.time, uid: @validate_facebook.uid, url: @validate_facebook.url, url_id: @validate_facebook.url_id }
    assert_redirected_to validate_facebook_path(assigns(:validate_facebook))
  end

  test "should destroy validate_facebook" do
    assert_difference('ValidateFacebook.count', -1) do
      delete :destroy, id: @validate_facebook
    end

    assert_redirected_to validate_facebooks_path
  end
end
