require 'test_helper'

class MmanutencaosTiposManutencaosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mmanutencaos_tipos_manutencaos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mmanutencaos_tipos_manutencao" do
    assert_difference('MmanutencaosTiposManutencao.count') do
      post :create, :mmanutencaos_tipos_manutencao => { }
    end

    assert_redirected_to mmanutencaos_tipos_manutencao_path(assigns(:mmanutencaos_tipos_manutencao))
  end

  test "should show mmanutencaos_tipos_manutencao" do
    get :show, :id => mmanutencaos_tipos_manutencaos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => mmanutencaos_tipos_manutencaos(:one).to_param
    assert_response :success
  end

  test "should update mmanutencaos_tipos_manutencao" do
    put :update, :id => mmanutencaos_tipos_manutencaos(:one).to_param, :mmanutencaos_tipos_manutencao => { }
    assert_redirected_to mmanutencaos_tipos_manutencao_path(assigns(:mmanutencaos_tipos_manutencao))
  end

  test "should destroy mmanutencaos_tipos_manutencao" do
    assert_difference('MmanutencaosTiposManutencao.count', -1) do
      delete :destroy, :id => mmanutencaos_tipos_manutencaos(:one).to_param
    end

    assert_redirected_to mmanutencaos_tipos_manutencaos_path
  end
end
