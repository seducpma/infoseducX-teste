require 'test_helper'

class OficiosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oficios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create oficio" do
    assert_difference('Oficio.count') do
      post :create, :oficio => { }
    end

    assert_redirected_to oficio_path(assigns(:oficio))
  end

  test "should show oficio" do
    get :show, :id => oficios(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => oficios(:one).to_param
    assert_response :success
  end

  test "should update oficio" do
    put :update, :id => oficios(:one).to_param, :oficio => { }
    assert_redirected_to oficio_path(assigns(:oficio))
  end

  test "should destroy oficio" do
    assert_difference('Oficio.count', -1) do
      delete :destroy, :id => oficios(:one).to_param
    end

    assert_redirected_to oficios_path
  end
end
