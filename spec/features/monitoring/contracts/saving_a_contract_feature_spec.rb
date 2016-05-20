require 'rails_helper'

feature "Contract management" do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :project_engineer)
      login_as(user, scope: :user)
    end

    scenario "then i can create a contract" do
      project = create(:project, cost: 1_000_000)
      contractor = create(:contractor, company: "Alfalfa")
      visit monitoring_project_path(project)
      click_link "New Sub Contractor"
      choose "Alfalfa"
      fill_in "Amount subcontracted", with: 100_000
      click_button "Save Contract"

      expect(page).to have_content("saved successfully")
    end
  end
end
