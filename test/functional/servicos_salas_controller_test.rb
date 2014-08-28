require 'test_helper'

class ServicosSalasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:servicos_salas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create servicos_sala" do
    assert_difference('ServicosSala.count') do
      post :create, :servicos_sala => { }
    end

    assert_redirected_to servicos_sala_path(assigns(:servicos_sala))
  end

  test "should show servicos_sala" do
    get :show, :id => servicos_salas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => servicos_salas(:one).to_param
    assert_response :success
  end

  test "should update servicos_sala" do
    put :update, :id => servicos_salas(:one).to_param, :servicos_sala => { }
    assert_redirected_to servicos_sala_path(assigns(:servicos_sala))
  end

  test "should destroy servicos_sala" do
    assert_difference('ServicosSala.count', -1) do
      delete :destroy, :id => servicos_salas(:one).to_param
    end

    assert_redirected_to servicos_salas_path
  end
end
