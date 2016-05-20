require 'rails_helper'

feature "Amount Revision" do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :project_engineer)
      login_as(user, scope: :user)
    end

    scenario "creating a time extension" do
      project = create(:project)
      work_detail = create(:work_detail, project: project)
      visit monitoring_work_detail_path(work_detail)
      click_link "New Time Extension"
      fill_in "Number of days", with: 10
      fill_in "Date", with: Time.zone.now
      fill_in "Remarks", with: "Due to Variation Order #2"
      click_button "Save"

      expect(page).to have_content("saved successfully")
    end
  end
end
 
