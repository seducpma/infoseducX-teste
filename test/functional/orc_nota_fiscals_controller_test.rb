require 'test_helper'

class OrcNotaFiscalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orc_nota_fiscals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orc_nota_fiscal" do
    assert_difference('OrcNotaFiscal.count') do
      post :create, :orc_nota_fiscal => { }
    end

    assert_redirected_to orc_nota_fiscal_path(assigns(:orc_nota_fiscal))
  end

  test "should show orc_nota_fiscal" do
    get :show, :id => orc_nota_fiscals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => orc_nota_fiscals(:one).to_param
    assert_response :success
  end

  test "should update orc_nota_fiscal" do
    put :update, :id => orc_nota_fiscals(:one).to_param, :orc_nota_fiscal => { }
    assert_redirected_to orc_nota_fiscal_path(assigns(:orc_nota_fiscal))
  end

  test "should destroy orc_nota_fiscal" do
    assert_difference('OrcNotaFiscal.count', -1) do
      delete :destroy, :id => orc_nota_fiscals(:one).to_param
    end

    assert_redirected_to orc_nota_fiscals_path
  end
end
