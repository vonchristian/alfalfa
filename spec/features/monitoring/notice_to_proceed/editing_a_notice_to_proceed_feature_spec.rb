require 'rails_helper'

feature "Editing a notice to proceed" do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :project_engineer)
      login_as(user, scope: :user)
    end
    scenario "then i can edit a notice to proceed with valid information" do
      project = create(:project, created_at: Time.zone.now.yesterday)
      notice_to_proceed = create(:notice_to_proceed, project: project, date: Time.zone.now.tomorrow)
      visit monitoring_project_path(project)
      click_link "Edit Notice To Proceed"
      fill_in "Date", with: Time.zone.now
      click_button "Save"

      expect(page).to have_content("saved successfully.")
    end
  end
end
