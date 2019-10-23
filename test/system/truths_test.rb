require "application_system_test_case"

class TruthsTest < ApplicationSystemTestCase
  setup do
    @truth = truths(:one)
  end

  test "visiting the index" do
    visit truths_url
    assert_selector "h1", text: "Truths"
  end

  test "creating a Truth" do
    visit truths_url
    click_on "New Truth"

    fill_in "Retweet count", with: @truth.retweet_count
    fill_in "Sent", with: @truth.sent
    fill_in "State", with: @truth.state
    fill_in "Text", with: @truth.text
    fill_in "Tweet", with: @truth.tweet_id
    click_on "Create Truth"

    assert_text "Truth was successfully created"
    click_on "Back"
  end

  test "updating a Truth" do
    visit truths_url
    click_on "Edit", match: :first

    fill_in "Retweet count", with: @truth.retweet_count
    fill_in "Sent", with: @truth.sent
    fill_in "State", with: @truth.state
    fill_in "Text", with: @truth.text
    fill_in "Tweet", with: @truth.tweet_id
    click_on "Update Truth"

    assert_text "Truth was successfully updated"
    click_on "Back"
  end

  test "destroying a Truth" do
    visit truths_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Truth was successfully destroyed"
  end
end
