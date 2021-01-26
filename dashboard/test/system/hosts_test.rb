require "application_system_test_case"

class HostsTest < ApplicationSystemTestCase
  setup do
    @host = hosts(:one)
  end

  test "visiting the index" do
    visit hosts_url
    assert_selector "h1", text: "Hosts"
  end

  test "creating a Host" do
    visit hosts_url
    click_on "New Host"

    fill_in "First seen", with: @host.first_seen
    fill_in "Hostname", with: @host.hostname
    fill_in "Ip", with: @host.ip
    fill_in "Last seen", with: @host.last_seen
    fill_in "User", with: @host.user_id
    click_on "Create Host"

    assert_text "Host was successfully created"
    click_on "Back"
  end

  test "updating a Host" do
    visit hosts_url
    click_on "Edit", match: :first

    fill_in "First seen", with: @host.first_seen
    fill_in "Hostname", with: @host.hostname
    fill_in "Ip", with: @host.ip
    fill_in "Last seen", with: @host.last_seen
    fill_in "User", with: @host.user_id
    click_on "Update Host"

    assert_text "Host was successfully updated"
    click_on "Back"
  end

  test "destroying a Host" do
    visit hosts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Host was successfully destroyed"
  end
end
