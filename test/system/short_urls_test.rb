require "application_system_test_case"

class ShortUrlsTest < ApplicationSystemTestCase
  setup do
    @short_url = short_urls(:one)
  end

  test "visiting the index" do
    visit short_urls_url
    assert_selector "h1", text: "Short urls"
  end

  test "should create short url" do
    visit short_urls_url
    click_on "New short url"

    fill_in "Counts", with: @short_url.counts
    fill_in "Last accessed at", with: @short_url.last_accessed_at
    fill_in "Shortcode", with: @short_url.shortcode
    fill_in "Url", with: @short_url.url
    click_on "Create Short url"

    assert_text "Short url was successfully created"
    click_on "Back"
  end

  test "should update Short url" do
    visit short_url_url(@short_url)
    click_on "Edit this short url", match: :first

    fill_in "Counts", with: @short_url.counts
    fill_in "Last accessed at", with: @short_url.last_accessed_at
    fill_in "Shortcode", with: @short_url.shortcode
    fill_in "Url", with: @short_url.url
    click_on "Update Short url"

    assert_text "Short url was successfully updated"
    click_on "Back"
  end

  test "should destroy Short url" do
    visit short_url_url(@short_url)
    click_on "Destroy this short url", match: :first

    assert_text "Short url was successfully destroyed"
  end
end
