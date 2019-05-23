require 'test_helper'

class OrcReservasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orc_reservas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orc_reserva" do
    assert_difference('OrcReserva.count') do
      post :create, :orc_reserva => { }
    end

    assert_redirected_to orc_reserva_path(assigns(:orc_reserva))
  end

  test "should show orc_reserva" do
    get :show, :id => orc_reservas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => orc_reservas(:one).to_param
    assert_response :success
  end

  test "should update orc_reserva" do
    put :update, :id => orc_reservas(:one).to_param, :orc_reserva => { }
    assert_redirected_to orc_reserva_path(assigns(:orc_reserva))
  end

  test "should destroy orc_reserva" do
    assert_difference('OrcReserva.count', -1) do
      delete :destroy, :id => orc_reservas(:one).to_param
    end

    assert_redirected_to orc_reservas_path
  end
end
