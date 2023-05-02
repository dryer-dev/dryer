require "test_helper"

class Admin::SitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_site = admin_sites(:one)
  end

  test "should get index" do
    get admin_sites_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_site_url
    assert_response :success
  end

  test "should create admin_site" do
    assert_difference("Admin::Site.count") do
      post admin_sites_url, params: { admin_site: {  } }
    end

    assert_redirected_to admin_site_url(Admin::Site.last)
  end

  test "should show admin_site" do
    get admin_site_url(@admin_site)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_site_url(@admin_site)
    assert_response :success
  end

  test "should update admin_site" do
    patch admin_site_url(@admin_site), params: { admin_site: {  } }
    assert_redirected_to admin_site_url(@admin_site)
  end

  test "should destroy admin_site" do
    assert_difference("Admin::Site.count", -1) do
      delete admin_site_url(@admin_site)
    end

    assert_redirected_to admin_sites_url
  end
end
