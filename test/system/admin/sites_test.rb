require "application_system_test_case"

class Admin::SitesTest < ApplicationSystemTestCase
  setup do
    @admin_site = admin_sites(:one)
  end

  test "visiting the index" do
    visit admin_sites_url
    assert_selector "h1", text: "Sites"
  end

  test "should create site" do
    visit admin_sites_url
    click_on "New site"

    click_on "Create Site"

    assert_text "Site was successfully created"
    click_on "Back"
  end

  test "should update Site" do
    visit admin_site_url(@admin_site)
    click_on "Edit this site", match: :first

    click_on "Update Site"

    assert_text "Site was successfully updated"
    click_on "Back"
  end

  test "should destroy Site" do
    visit admin_site_url(@admin_site)
    click_on "Destroy this site", match: :first

    assert_text "Site was successfully destroyed"
  end
end
