require 'test_helper'

class AcompanhamentosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:acompanhamentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create acompanhamento" do
    assert_difference('Acompanhamento.count') do
      post :create, :acompanhamento => { }
    end

    assert_redirected_to acompanhamento_path(assigns(:acompanhamento))
  end

  test "should show acompanhamento" do
    get :show, :id => acompanhamentos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => acompanhamentos(:one).to_param
    assert_response :success
  end

  test "should update acompanhamento" do
    put :update, :id => acompanhamentos(:one).to_param, :acompanhamento => { }
    assert_redirected_to acompanhamento_path(assigns(:acompanhamento))
  end

  test "should destroy acompanhamento" do
    assert_difference('Acompanhamento.count', -1) do
      delete :destroy, :id => acompanhamentos(:one).to_param
    end

    assert_redirected_to acompanhamentos_path
  end
end
