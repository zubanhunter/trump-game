require 'test_helper'

class TruthsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @truth = truths(:one)
  end

  test "should get index" do
    get truths_url
    assert_response :success
  end

  test "should get new" do
    get new_truth_url
    assert_response :success
  end

  test "should create truth" do
    assert_difference('Truth.count') do
      post truths_url, params: { truth: { retweet_count: @truth.retweet_count, sent: @truth.sent, state: @truth.state, text: @truth.text, tweet_id: @truth.tweet_id } }
    end

    assert_redirected_to truth_url(Truth.last)
  end

  test "should show truth" do
    get truth_url(@truth)
    assert_response :success
  end

  test "should get edit" do
    get edit_truth_url(@truth)
    assert_response :success
  end

  test "should update truth" do
    patch truth_url(@truth), params: { truth: { retweet_count: @truth.retweet_count, sent: @truth.sent, state: @truth.state, text: @truth.text, tweet_id: @truth.tweet_id } }
    assert_redirected_to truth_url(@truth)
  end

  test "should destroy truth" do
    assert_difference('Truth.count', -1) do
      delete truth_url(@truth)
    end

    assert_redirected_to truths_url
  end
end
