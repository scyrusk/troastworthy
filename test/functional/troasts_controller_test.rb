require 'test_helper'

class TroastsControllerTest < ActionController::TestCase
  setup do
    @troast = troasts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:troasts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create troast" do
    assert_difference('Troast.count') do
      post :create, troast: @troast.attributes
    end

    assert_redirected_to troast_path(assigns(:troast))
  end

  test "should show troast" do
    get :show, id: @troast.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @troast.to_param
    assert_response :success
  end

  test "should update troast" do
    put :update, id: @troast.to_param, troast: @troast.attributes
    assert_redirected_to troast_path(assigns(:troast))
  end

  test "should destroy troast" do
    assert_difference('Troast.count', -1) do
      delete :destroy, id: @troast.to_param
    end

    assert_redirected_to troasts_path
  end
end
