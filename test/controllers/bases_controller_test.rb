require 'test_helper'

class BasesControllerTest < ActionController::TestCase
  setup do
    @basis = bases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create basis" do
    assert_difference('Basis.count') do
      post :create, basis: { maintenance: @basis.maintenance, service_text: @basis.service_text }
    end

    assert_redirected_to basis_path(assigns(:basis))
  end

  test "should show basis" do
    get :show, id: @basis
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @basis
    assert_response :success
  end

  test "should update basis" do
    patch :update, id: @basis, basis: { maintenance: @basis.maintenance, service_text: @basis.service_text }
    assert_redirected_to basis_path(assigns(:basis))
  end

  test "should destroy basis" do
    assert_difference('Basis.count', -1) do
      delete :destroy, id: @basis
    end

    assert_redirected_to bases_path
  end
end
