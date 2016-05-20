require 'rails_helper'

feature "Editing a project feature", type: :feature  do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :project_engineer)
      login_as(user , :scope => :user)
    end

    scenario "then i can edit a project" do
      project = create(:project)
      visit monitoring_project_path(project)
      click_link "Edit Project"
      fill_in "Project Name", with: "Road"
      fill_in "Contract ID", with: "FFGG455"
      fill_in "Duration", with: 90
      fill_in "Cost", with: 100_000
      fill_in "Location", with: "Lagawe, Ifugao"
      fill_in "Implementing Office", with: "DPWH"

      click_button "Save Project"

    expect(page).to have_content "updated successfully."
    end
  end
end
