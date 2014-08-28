require 'test_helper'

class SalasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:salas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sala" do
    assert_difference('Sala.count') do
      post :create, :sala => { }
    end

    assert_redirected_to sala_path(assigns(:sala))
  end

  test "should show sala" do
    get :show, :id => salas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => salas(:one).to_param
    assert_response :success
  end

  test "should update sala" do
    put :update, :id => salas(:one).to_param, :sala => { }
    assert_redirected_to sala_path(assigns(:sala))
  end

  test "should destroy sala" do
    assert_difference('Sala.count', -1) do
      delete :destroy, :id => salas(:one).to_param
    end

    assert_redirected_to salas_path
  end
end
