require 'test_helper'

class BackendsControllerTest < ActionController::TestCase
  setup do
    @backend = backends(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:backends)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create backend" do
    assert_difference('Backend.count') do
      post :create, backend: @backend.attributes
    end

    assert_redirected_to backend_path(assigns(:backend))
  end

  test "should show backend" do
    get :show, id: @backend.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @backend.to_param
    assert_response :success
  end

  test "should update backend" do
    put :update, id: @backend.to_param, backend: @backend.attributes
    assert_redirected_to backend_path(assigns(:backend))
  end

  test "should destroy backend" do
    assert_difference('Backend.count', -1) do
      delete :destroy, id: @backend.to_param
    end

    assert_redirected_to backends_path
  end
end
