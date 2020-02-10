require "rails_helper"

RSpec.describe "Users page test", :type => :feature do
  before :all do
    @user = create(:user)
    @userx = create(:userx)
    @admin = create(:admin)
  end

  before(:each) do
    visit("/login")
    fill_in "session[email]", with: @user.email
    fill_in "session[password]", with: @user.password
    click_button "Log in"
  end

  def logout_user
    find(".user-profile").click
    find(".logout__link").click
  end

  feature "User view all Users page" do
    scenario "expect to see all users and their article counts" do
      visit("/users")
      expect(page).to have_text "Featured Bloggers"
      expect(page).to have_css(".blogger-info")
      expect(page).to have_content "#{@user.username}"
      expect(page).to have_content "#{@userx.username}"
      expect(page).to have_content "#{@userx.articles.length} articles"
    end
  end

  feature "User can view another user's profile" do
    scenario "expect to see user's details and articles if any" do
      visit("/users/#{@userx.id}")
      expect(page).to have_text "#{@userx.username}'s page"
      expect(page).to have_content @userx.email
    end

    scenario "expect to redirect to all users page if user does not exist" do
      visit("/users/100000")
      expect(page).to have_current_path(users_path)
    end
  end

  feature "User update their profile" do
    scenario "expect to see the update form" do
      visit("/users/#{@user.id}")
      fill_in "user[username]", with: "Khalid"
      fill_in "user[biography]", with: "I love writing!"
      expect(find_field("user[username]").value).to eq "Khalid"
      expect(find_field("user[biography]").value).to eq "I love writing!"
    end

    scenario "expect user to successfully update their profile" do
      visit("/users/#{@user.id}")
      fill_in "user[username]", with: "Khalid"
      fill_in "user[biography]", with: "I love writing!"
      click_button "Update"
      expect(page).to have_text "Your account was updated successfully"
      expect(page).to have_current_path(user_path(@user))
      expect(page).to have_content "Khalid's page"
      expect(page).not_to have_content "#{@user.username}'s page"
    end

    scenario "expect error message when the username field is blank" do
      visit("/users/#{@user.id}")
      fill_in "user[username]", with: ""
      click_button "Update"
      expect(page).to have_text "Username can't be blank"
      expect(page).to have_current_path(user_path(@user))
      expect(page).to have_content "#{@user.username}'s page"
    end
  end

  feature "Admin can delete a user account" do
    scenario "expect an admin to successfully delete a user account and the articles" do
      logout_user
      visit("/login")
      fill_in "session[email]", with: @admin.email
      fill_in "session[password]", with: @admin.password
      click_button "Log in"
      visit("/users/#{@userx.id}")
      find("#delete-btn").click
      expect(page).to have_text "User and all articles created by user have been deleted!"
      expect(page).to have_current_path(users_path)
    end
  end
end
