require 'test_helper'

class MmanutencaosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mmanutencaos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mmanutencao" do
    assert_difference('Mmanutencao.count') do
      post :create, :mmanutencao => { }
    end

    assert_redirected_to mmanutencao_path(assigns(:mmanutencao))
  end

  test "should show mmanutencao" do
    get :show, :id => mmanutencaos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => mmanutencaos(:one).to_param
    assert_response :success
  end

  test "should update mmanutencao" do
    put :update, :id => mmanutencaos(:one).to_param, :mmanutencao => { }
    assert_redirected_to mmanutencao_path(assigns(:mmanutencao))
  end

  test "should destroy mmanutencao" do
    assert_difference('Mmanutencao.count', -1) do
      delete :destroy, :id => mmanutencaos(:one).to_param
    end

    assert_redirected_to mmanutencaos_path
  end
end
