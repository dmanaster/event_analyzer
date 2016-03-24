require 'test_helper'

class AttendeesControllerTest < ActionController::TestCase
  setup do
    @attendee = attendees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attendees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attendee" do
    assert_difference('Attendee.count') do
      post :create, attendee: { address_1: @attendee.address_1, address_2: @attendee.address_2, city: @attendee.city, company: @attendee.company, country: @attendee.country, direct_phone: @attendee.direct_phone, email: @attendee.email, first_name: @attendee.first_name, last_name: @attendee.last_name, mobile_phone: @attendee.mobile_phone, state: @attendee.state, title: @attendee.title, zip_code: @attendee.zip_code }
    end

    assert_redirected_to attendee_path(assigns(:attendee))
  end

  test "should show attendee" do
    get :show, id: @attendee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attendee
    assert_response :success
  end

  test "should update attendee" do
    patch :update, id: @attendee, attendee: { address_1: @attendee.address_1, address_2: @attendee.address_2, city: @attendee.city, company: @attendee.company, country: @attendee.country, direct_phone: @attendee.direct_phone, email: @attendee.email, first_name: @attendee.first_name, last_name: @attendee.last_name, mobile_phone: @attendee.mobile_phone, state: @attendee.state, title: @attendee.title, zip_code: @attendee.zip_code }
    assert_redirected_to attendee_path(assigns(:attendee))
  end

  test "should destroy attendee" do
    assert_difference('Attendee.count', -1) do
      delete :destroy, id: @attendee
    end

    assert_redirected_to attendees_path
  end
end
