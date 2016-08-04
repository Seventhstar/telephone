require 'test_helper'

class GroupMagsControllerTest < ActionController::TestCase
  setup do
    @group_mag = group_mags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_mags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_mag" do
    assert_difference('GroupMag.count') do
      post :create, group_mag: @group_mag.attributes
    end

    assert_redirected_to group_mag_path(assigns(:group_mag))
  end

  test "should show group_mag" do
    get :show, id: @group_mag.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_mag.to_param
    assert_response :success
  end

  test "should update group_mag" do
    put :update, id: @group_mag.to_param, group_mag: @group_mag.attributes
    assert_redirected_to group_mag_path(assigns(:group_mag))
  end

  test "should destroy group_mag" do
    assert_difference('GroupMag.count', -1) do
      delete :destroy, id: @group_mag.to_param
    end

    assert_redirected_to group_mags_path
  end
end
