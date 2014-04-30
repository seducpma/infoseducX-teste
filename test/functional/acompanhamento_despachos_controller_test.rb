require 'test_helper'

class AcompanhamentoDespachosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:acompanhamento_despachos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create acompanhamento_despacho" do
    assert_difference('AcompanhamentoDespacho.count') do
      post :create, :acompanhamento_despacho => { }
    end

    assert_redirected_to acompanhamento_despacho_path(assigns(:acompanhamento_despacho))
  end

  test "should show acompanhamento_despacho" do
    get :show, :id => acompanhamento_despachos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => acompanhamento_despachos(:one).to_param
    assert_response :success
  end

  test "should update acompanhamento_despacho" do
    put :update, :id => acompanhamento_despachos(:one).to_param, :acompanhamento_despacho => { }
    assert_redirected_to acompanhamento_despacho_path(assigns(:acompanhamento_despacho))
  end

  test "should destroy acompanhamento_despacho" do
    assert_difference('AcompanhamentoDespacho.count', -1) do
      delete :destroy, :id => acompanhamento_despachos(:one).to_param
    end

    assert_redirected_to acompanhamento_despachos_path
  end
end
