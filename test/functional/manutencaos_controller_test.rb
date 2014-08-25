require 'test_helper'

class ManutencaosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manutencaos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manutencao" do
    assert_difference('Manutencao.count') do
      post :create, :manutencao => { }
    end

    assert_redirected_to manutencao_path(assigns(:manutencao))
  end

  test "should show manutencao" do
    get :show, :id => manutencaos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => manutencaos(:one).to_param
    assert_response :success
  end

  test "should update manutencao" do
    put :update, :id => manutencaos(:one).to_param, :manutencao => { }
    assert_redirected_to manutencao_path(assigns(:manutencao))
  end

  test "should destroy manutencao" do
    assert_difference('Manutencao.count', -1) do
      delete :destroy, :id => manutencaos(:one).to_param
    end

    assert_redirected_to manutencaos_path
  end
end
