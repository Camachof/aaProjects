require 'rails_helper'
require 'spec_helper'
# require './spec/factories/goals.rb'

feature "User show" do
  let!(:private_goal) { FactoryGirl.create(:private_goal) }
  let!(:public_goal) { FactoryGirl.create(:public_goal) }

  before(:each) do
    signup("Bob")
  end

  it "has a show page" do
    visit(user_url(User.find_by_username("Bob")))
    expect(page).to have_content "Bob's Profile"
  end


  it "lists public goals" do
    visit(user_url(User.find_by_username("Bob")))
    expect(page).to have_content public_goal.title
  end

  it " doesn't list private goals" do
    visit(user_url(User.find_by_username("Bob")))
    expect(page).to_not have_content private_goal.title
  end

  # it "shows remaining cheers" do
  #   expect(page).to have_content "Cheers go here"
  # end

  it "shows your username" do
    expect(page).to have_content "Bob"
  end
end
