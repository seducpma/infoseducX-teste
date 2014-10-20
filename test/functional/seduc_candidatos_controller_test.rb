require 'test_helper'

class SeducCandidatosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seduc_candidatos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seduc_candidato" do
    assert_difference('SeducCandidato.count') do
      post :create, :seduc_candidato => { }
    end

    assert_redirected_to seduc_candidato_path(assigns(:seduc_candidato))
  end

  test "should show seduc_candidato" do
    get :show, :id => seduc_candidatos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => seduc_candidatos(:one).to_param
    assert_response :success
  end

  test "should update seduc_candidato" do
    put :update, :id => seduc_candidatos(:one).to_param, :seduc_candidato => { }
    assert_redirected_to seduc_candidato_path(assigns(:seduc_candidato))
  end

  test "should destroy seduc_candidato" do
    assert_difference('SeducCandidato.count', -1) do
      delete :destroy, :id => seduc_candidatos(:one).to_param
    end

    assert_redirected_to seduc_candidatos_path
  end
end
