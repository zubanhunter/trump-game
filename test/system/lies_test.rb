require "application_system_test_case"

class LiesTest < ApplicationSystemTestCase
  setup do
    @ly = lies(:one)
  end

  test "visiting the index" do
    visit lies_url
    assert_selector "h1", text: "Lies"
  end

  test "creating a Lie" do
    visit lies_url
    click_on "New Lie"

    fill_in "Model order", with: @ly.model_order
    fill_in "Model version", with: @ly.model_version
    fill_in "State", with: @ly.state
    fill_in "Text", with: @ly.text
    click_on "Create Lie"

    assert_text "Lie was successfully created"
    click_on "Back"
  end

  test "updating a Lie" do
    visit lies_url
    click_on "Edit", match: :first

    fill_in "Model order", with: @ly.model_order
    fill_in "Model version", with: @ly.model_version
    fill_in "State", with: @ly.state
    fill_in "Text", with: @ly.text
    click_on "Update Lie"

    assert_text "Lie was successfully updated"
    click_on "Back"
  end

  test "destroying a Lie" do
    visit lies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lie was successfully destroyed"
  end
end
