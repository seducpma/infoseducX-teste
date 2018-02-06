require 'test_helper'

class CertificadosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:certificados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create certificado" do
    assert_difference('Certificado.count') do
      post :create, :certificado => { }
    end

    assert_redirected_to certificado_path(assigns(:certificado))
  end

  test "should show certificado" do
    get :show, :id => certificados(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => certificados(:one).to_param
    assert_response :success
  end

  test "should update certificado" do
    put :update, :id => certificados(:one).to_param, :certificado => { }
    assert_redirected_to certificado_path(assigns(:certificado))
  end

  test "should destroy certificado" do
    assert_difference('Certificado.count', -1) do
      delete :destroy, :id => certificados(:one).to_param
    end

    assert_redirected_to certificados_path
  end
end
