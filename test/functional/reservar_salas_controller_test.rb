require 'test_helper'

class ReservarSalasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reservar_salas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reservar_sala" do
    assert_difference('ReservarSala.count') do
      post :create, :reservar_sala => { }
    end

    assert_redirected_to reservar_sala_path(assigns(:reservar_sala))
  end

  test "should show reservar_sala" do
    get :show, :id => reservar_salas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => reservar_salas(:one).to_param
    assert_response :success
  end

  test "should update reservar_sala" do
    put :update, :id => reservar_salas(:one).to_param, :reservar_sala => { }
    assert_redirected_to reservar_sala_path(assigns(:reservar_sala))
  end

  test "should destroy reservar_sala" do
    assert_difference('ReservarSala.count', -1) do
      delete :destroy, :id => reservar_salas(:one).to_param
    end

    assert_redirected_to reservar_salas_path
  end
end
