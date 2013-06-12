require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get feedback" do
    get :feedback
    assert_response :success
  end

end
