require 'test_helper'

class OrcNotaFiscalItensControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orc_nota_fiscal_itens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orc_nota_fiscal_iten" do
    assert_difference('OrcNotaFiscalIten.count') do
      post :create, :orc_nota_fiscal_iten => { }
    end

    assert_redirected_to orc_nota_fiscal_iten_path(assigns(:orc_nota_fiscal_iten))
  end

  test "should show orc_nota_fiscal_iten" do
    get :show, :id => orc_nota_fiscal_itens(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => orc_nota_fiscal_itens(:one).to_param
    assert_response :success
  end

  test "should update orc_nota_fiscal_iten" do
    put :update, :id => orc_nota_fiscal_itens(:one).to_param, :orc_nota_fiscal_iten => { }
    assert_redirected_to orc_nota_fiscal_iten_path(assigns(:orc_nota_fiscal_iten))
  end

  test "should destroy orc_nota_fiscal_iten" do
    assert_difference('OrcNotaFiscalIten.count', -1) do
      delete :destroy, :id => orc_nota_fiscal_itens(:one).to_param
    end

    assert_redirected_to orc_nota_fiscal_itens_path
  end
end
