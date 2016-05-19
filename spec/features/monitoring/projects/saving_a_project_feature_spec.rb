require 'rails_helper'

feature "Project management", type: :feature  do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :project_engineer)
      login_as(user , :scope => :user)
    end
    scenario "then i can visit project index page" do
      visit monitoring_projects_path
    end
    scenario "then i can save a project" do
      visit monitoring_projects_path
      click_link "New Project"

      fill_in "Project Name", with: "Road"
      fill_in "Contract ID", with: "FFGG455"
      fill_in "Duration", with: 90
      fill_in "Cost", with: 100_000
      fill_in "Location", with: "Lagawe, Ifugao"
      fill_in "Implementing Office", with: "DPWH"

      click_button "Save Project"

    expect(page).to have_content "saved successfully."
    end
  end
end
