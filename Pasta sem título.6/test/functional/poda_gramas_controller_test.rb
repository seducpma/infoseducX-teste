require 'test_helper'

class PodaGramasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poda_gramas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poda_grama" do
    assert_difference('PodaGrama.count') do
      post :create, :poda_grama => { }
    end

    assert_redirected_to poda_grama_path(assigns(:poda_grama))
  end

  test "should show poda_grama" do
    get :show, :id => poda_gramas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => poda_gramas(:one).to_param
    assert_response :success
  end

  test "should update poda_grama" do
    put :update, :id => poda_gramas(:one).to_param, :poda_grama => { }
    assert_redirected_to poda_grama_path(assigns(:poda_grama))
  end

  test "should destroy poda_grama" do
    assert_difference('PodaGrama.count', -1) do
      delete :destroy, :id => poda_gramas(:one).to_param
    end

    assert_redirected_to poda_gramas_path
  end
end
