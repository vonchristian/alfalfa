require 'rails_helper'

feature "Saving a notice to proceed" do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :project_engineer)
      login_as(user, scope: :user)
    end
    scenario "with valid information" do
      project = create(:project)
      expect(project.notice_to_proceed).to be_nil
      visit monitoring_project_path(project)
      click_link "Add Notice To Proceed"
      # # fill_in "Date", with: Time.zone.now
      # # click_button "Save"
      # #
      # # expect(page).to have_content("saved successfully.")
    end
  end
end
