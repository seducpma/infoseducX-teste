require 'test_helper'

class PrefprotocolosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prefprotocolos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prefprotocolo" do
    assert_difference('Prefprotocolo.count') do
      post :create, :prefprotocolo => { }
    end

    assert_redirected_to prefprotocolo_path(assigns(:prefprotocolo))
  end

  test "should show prefprotocolo" do
    get :show, :id => prefprotocolos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => prefprotocolos(:one).to_param
    assert_response :success
  end

  test "should update prefprotocolo" do
    put :update, :id => prefprotocolos(:one).to_param, :prefprotocolo => { }
    assert_redirected_to prefprotocolo_path(assigns(:prefprotocolo))
  end

  test "should destroy prefprotocolo" do
    assert_difference('Prefprotocolo.count', -1) do
      delete :destroy, :id => prefprotocolos(:one).to_param
    end

    assert_redirected_to prefprotocolos_path
  end
end
