require 'test_helper'

class OrcAtasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orc_atas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orc_ata" do
    assert_difference('OrcAta.count') do
      post :create, :orc_ata => { }
    end

    assert_redirected_to orc_ata_path(assigns(:orc_ata))
  end

  test "should show orc_ata" do
    get :show, :id => orc_atas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => orc_atas(:one).to_param
    assert_response :success
  end

  test "should update orc_ata" do
    put :update, :id => orc_atas(:one).to_param, :orc_ata => { }
    assert_redirected_to orc_ata_path(assigns(:orc_ata))
  end

  test "should destroy orc_ata" do
    assert_difference('OrcAta.count', -1) do
      delete :destroy, :id => orc_atas(:one).to_param
    end

    assert_redirected_to orc_atas_path
  end
end
