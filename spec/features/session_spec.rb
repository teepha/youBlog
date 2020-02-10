require "rails_helper"

RSpec.describe "Sessions test", :type => :feature do
  before :all do
    @user = create(:user)
  end

  before(:each) do
    visit("/login")
  end

  def stub_valid_login_request
    fill_in "session[email]", with: @user.email
    fill_in "session[password]", with: @user.password
    click_button "Log in"
  end

  def stub_login_details
    fill_in "session[email]", with: "test.user@gmail.com"
    fill_in "session[password]", with: "test_password"
  end

  feature "Login page" do
    scenario "expect to see the login page" do
      expect(page).to have_content("Log in to your account")
    end

    scenario "expect to see the login form" do
      stub_login_details
      expect(find_field("session[email]").value).to eq "test.user@gmail.com"
      expect(find_field("session[password]").value).to eq "test_password"
    end

    scenario "expect error message if the input fields are blank" do
      fill_in "session[email]", with: ""
      fill_in "session[password]", with: ""
      click_button "Log in"
      expect(page).to have_text "Invalid login details!"
    end
  end

  feature "User can login" do
    scenario "expect users to login successfully" do
      stub_valid_login_request
      expect(page).to have_text "Welcome back #{@user.username} : )"
    end

    scenario "expect to redirect registered users to the users page" do
      stub_valid_login_request
      expect(page).to have_current_path(user_path(@user))
      expect(page).to have_text "#{@user.username}'s page"
      expect(page).to have_content @user.email
    end

    scenario "expect to redirect non-registered users to the login page" do
      stub_login_details
      click_button "Log in"
      expect(page).to have_current_path(login_path)
    end
  end

  feature "User can logout" do
    scenario "expect users to be able to logout successfully" do
      stub_valid_login_request
      find(".user-profile").click
      find(".logout__link").click
      expect(page).to have_current_path(articles_path)
    end
  end
end