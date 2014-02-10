require 'test_helper'

class ServicosInternosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:servicos_internos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create servicos_interno" do
    assert_difference('ServicosInterno.count') do
      post :create, :servicos_interno => { }
    end

    assert_redirected_to servicos_interno_path(assigns(:servicos_interno))
  end

  test "should show servicos_interno" do
    get :show, :id => servicos_internos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => servicos_internos(:one).to_param
    assert_response :success
  end

  test "should update servicos_interno" do
    put :update, :id => servicos_internos(:one).to_param, :servicos_interno => { }
    assert_redirected_to servicos_interno_path(assigns(:servicos_interno))
  end

  test "should destroy servicos_interno" do
    assert_difference('ServicosInterno.count', -1) do
      delete :destroy, :id => servicos_internos(:one).to_param
    end

    assert_redirected_to servicos_internos_path
  end
end
