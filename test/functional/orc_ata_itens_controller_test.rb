require 'test_helper'

class OrcAtaItensControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orc_ata_itens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orc_ata_iten" do
    assert_difference('OrcAtaIten.count') do
      post :create, :orc_ata_iten => { }
    end

    assert_redirected_to orc_ata_iten_path(assigns(:orc_ata_iten))
  end

  test "should show orc_ata_iten" do
    get :show, :id => orc_ata_itens(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => orc_ata_itens(:one).to_param
    assert_response :success
  end

  test "should update orc_ata_iten" do
    put :update, :id => orc_ata_itens(:one).to_param, :orc_ata_iten => { }
    assert_redirected_to orc_ata_iten_path(assigns(:orc_ata_iten))
  end

  test "should destroy orc_ata_iten" do
    assert_difference('OrcAtaIten.count', -1) do
      delete :destroy, :id => orc_ata_itens(:one).to_param
    end

    assert_redirected_to orc_ata_itens_path
  end
end
