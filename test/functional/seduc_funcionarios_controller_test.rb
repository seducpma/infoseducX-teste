require 'test_helper'

class SeducFuncionariosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seduc_funcionarios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seduc_funcionario" do
    assert_difference('SeducFuncionario.count') do
      post :create, :seduc_funcionario => { }
    end

    assert_redirected_to seduc_funcionario_path(assigns(:seduc_funcionario))
  end

  test "should show seduc_funcionario" do
    get :show, :id => seduc_funcionarios(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => seduc_funcionarios(:one).to_param
    assert_response :success
  end

  test "should update seduc_funcionario" do
    put :update, :id => seduc_funcionarios(:one).to_param, :seduc_funcionario => { }
    assert_redirected_to seduc_funcionario_path(assigns(:seduc_funcionario))
  end

  test "should destroy seduc_funcionario" do
    assert_difference('SeducFuncionario.count', -1) do
      delete :destroy, :id => seduc_funcionarios(:one).to_param
    end

    assert_redirected_to seduc_funcionarios_path
  end
end
