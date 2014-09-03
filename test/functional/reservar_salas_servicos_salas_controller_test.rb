require 'test_helper'

class ReservarSalasServicosSalasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reservar_salas_servicos_salas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reservar_salas_servicos_sala" do
    assert_difference('ReservarSalasServicosSala.count') do
      post :create, :reservar_salas_servicos_sala => { }
    end

    assert_redirected_to reservar_salas_servicos_sala_path(assigns(:reservar_salas_servicos_sala))
  end

  test "should show reservar_salas_servicos_sala" do
    get :show, :id => reservar_salas_servicos_salas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => reservar_salas_servicos_salas(:one).to_param
    assert_response :success
  end

  test "should update reservar_salas_servicos_sala" do
    put :update, :id => reservar_salas_servicos_salas(:one).to_param, :reservar_salas_servicos_sala => { }
    assert_redirected_to reservar_salas_servicos_sala_path(assigns(:reservar_salas_servicos_sala))
  end

  test "should destroy reservar_salas_servicos_sala" do
    assert_difference('ReservarSalasServicosSala.count', -1) do
      delete :destroy, :id => reservar_salas_servicos_salas(:one).to_param
    end

    assert_redirected_to reservar_salas_servicos_salas_path
  end
end
