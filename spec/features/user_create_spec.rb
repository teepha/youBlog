require "rails_helper"

RSpec.describe "User Signup test", :type => :feature do
  before :all do
    @user = build(:user)
    @userx = create(:userx)
  end

  before(:each) do
    visit("/signup")
  end

  def stub_valid_request
    fill_in "user[username]", with: @user.username
    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: @user.password
    click_button "Sign up"
  end

  def stub_invalid_request
    fill_in "user[username]", with: @userx.username
    fill_in "user[email]", with: @userx.email
    fill_in "user[password]", with: @userx.password
    click_button "Sign up"
  end


  feature "Signup page" do
    scenario "expect to see the signup page" do
      expect(page).to have_content("Sign up for free to start sharing your inspiration and story on youBlog")
    end

    scenario "expect to see the signup form" do
      fill_in "user[username]", with: "TestUser"
      fill_in "user[email]", with: "test.user@gmail.com"
      fill_in "user[password]", with: "test_password"
      expect(find_field("user[email]").value).to eq "test.user@gmail.com"
      expect(find_field("user[password]").value).to eq "test_password"
    end

    scenario "expect error message if the input fields are blank" do
      fill_in "user[username]", with: ""
      fill_in "user[email]", with: ""
      fill_in "user[password]", with: ""
      click_button "Sign up"
      expect(page).to have_text "Username can't be blank"
    end
  end

  feature "Create a new User account" do
    scenario "expect users to be able to signup successfully" do
      stub_valid_request
      expect(page).to have_text "Welcome to youBlog #{@user.username}"
    end

    scenario "expect redirect to the users page" do
      stub_valid_request
      expect(page).to have_text "#{@user.username}'s page"
      expect(page).to have_content @user.email
    end

    scenario "expect redirect to the signup page if email already exists" do
      stub_invalid_request
      expect(page).to have_current_path(signup_path)
      expect(page).to have_text "Email has already been taken"
    end
  end
end
