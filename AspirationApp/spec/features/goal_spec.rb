require 'rails_helper'
require 'spec_helper'
# require './spec/factories/goals.rb'

feature "Goals index" do
  let!(:private_goal) { FactoryGirl.create(:private_goal) }
  let!(:public_goal) { FactoryGirl.create(:public_goal) }

  before(:each) do
    signup("Bob")
  end

  it "has an index page" do
    visit goals_url
    expect(page).to have_content "Your Goals"
  end

  it "redirects users to login page when not logged in" do
    logout
    visit(goals_url)
    expect(page).to have_content "Log In"
  end

  it "lists public goals on the index page" do
    visit(goals_url)
    expect(page).to have_content public_goal.title
  end

  it "lists private goals on the index page" do
    visit(goals_url)
    expect(page).to have_content private_goal.title
  end

  # it "shows remaining cheers" do
  #   expect(page).to have_content "Cheers go here"
  # end

  it "shows your username" do
    expect(page).to have_content "Bob"
  end
end

feature "goal show page" do
  it "has a show page" do
    expect(page).to have_content "Goal:"
  end

  it "displays comments" do

  end

  it "has button to save comments" do

  end

  # it "has button that redirect to users index" do
  #
  # end

  it "has to display current goal" do

  end


end
