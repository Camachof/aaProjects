require 'rails_helper'
require 'spec_helper'

feature "the signup process" do
  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    before(:each) do
      signup("Bob")
    end

    it "redirects to homepage after signup" do
      expect(page).to have_content "Goals"
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content "Bob"
    end
  end
end

feature "logging in" do
  before(:each) do
    signup("Bob")
    sign_in("Bob")
  end

  it "shows username on the homepage after login" do
    expect(page).to have_content "Bob"
  end

  it "redirects to homepage after sign_in" do
    expect(page).to have_content "Goals"
  end

  it "shows username on the homepage after sign_in" do
    expect(page).to have_content "Bob"
  end
end


feature "logging out" do
  before(:each) do
    signup("Bob")
    sign_in("Bob")
  end
  it "begins with logged out state" do
    expect(page).to have_content "Goals"
  end


  it "doesn't show username on the homepage after logout" do
    click_button "Log Out"
    expect(page).to_not have_content "Bob"
  end
end
