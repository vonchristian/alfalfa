require 'rails_helper'

feature "Work Accomplishment management", type: :feature do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :project_engineer)
      login_as(user , :scope => :user)
    end
    scenario "then i can save a work accomplishment" do
      project = create(:project)
      work_detail = create(:work_detail, project: project)
      visit monitoring_work_detail_path(work_detail)
      click_link "New Work Accomplishment"
      fill_in "Quantity", with: 1
      fill_in "Date accomplished", with: Time.zone.now
      fill_in "Remarks", with: 'Materials delivered to the site'
      click_button "Save"

      expect(page).to have_content("saved successfully")
    end
  end
end
