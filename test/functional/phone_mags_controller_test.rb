require 'test_helper'

class PhoneMagsControllerTest < ActionController::TestCase
  setup do
    @phone_mag = phone_mags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phone_mags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phone_mag" do
    assert_difference('PhoneMag.count') do
      post :create, phone_mag: @phone_mag.attributes
    end

    assert_redirected_to phone_mag_path(assigns(:phone_mag))
  end

  test "should show phone_mag" do
    get :show, id: @phone_mag.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phone_mag.to_param
    assert_response :success
  end

  test "should update phone_mag" do
    put :update, id: @phone_mag.to_param, phone_mag: @phone_mag.attributes
    assert_redirected_to phone_mag_path(assigns(:phone_mag))
  end

  test "should destroy phone_mag" do
    assert_difference('PhoneMag.count', -1) do
      delete :destroy, id: @phone_mag.to_param
    end

    assert_redirected_to phone_mags_path
  end
end
