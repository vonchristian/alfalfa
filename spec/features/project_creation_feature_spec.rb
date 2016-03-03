require "rails_helper"

RSpec.feature "Project management", :type => :feature do
  before(:each) do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  scenario "User creates a new project" do
    visit "/projects/new"

    fill_in "Name", :with => "Road Widening"
    fill_in "Contract ID", with: "1231322"
    fill_in "Duration", with: '120'
    fill_in "Cost", with: '12000000'
    fill_in "Location", with: 'Kiangan, Ifugao'
    fill_in "Implementing Office", with: 'DPWH'
    click_button "Save Project"

    expect(page).to have_content("Project was successfully saved.")
  end
end


