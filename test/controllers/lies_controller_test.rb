require 'test_helper'

class LiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ly = lies(:one)
  end

  test "should get index" do
    get lies_url
    assert_response :success
  end

  test "should get new" do
    get new_ly_url
    assert_response :success
  end

  test "should create ly" do
    assert_difference('Lie.count') do
      post lies_url, params: { ly: { model_order: @ly.model_order, model_version: @ly.model_version, state: @ly.state, text: @ly.text } }
    end

    assert_redirected_to ly_url(Lie.last)
  end

  test "should show ly" do
    get ly_url(@ly)
    assert_response :success
  end

  test "should get edit" do
    get edit_ly_url(@ly)
    assert_response :success
  end

  test "should update ly" do
    patch ly_url(@ly), params: { ly: { model_order: @ly.model_order, model_version: @ly.model_version, state: @ly.state, text: @ly.text } }
    assert_redirected_to ly_url(@ly)
  end

  test "should destroy ly" do
    assert_difference('Lie.count', -1) do
      delete ly_url(@ly)
    end

    assert_redirected_to lies_url
  end
end
