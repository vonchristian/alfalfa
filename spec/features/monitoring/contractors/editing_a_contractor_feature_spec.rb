require 'rails_helper'

feature "Contractor editing feature" do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :project_engineer)
      login_as(user, scope: :user)
    end

    scenario "then i can edit a contractor" do
      contractor = create(:contractor)
      visit monitoring_contractor_path(contractor)
      click_link "Update"
      fill_in "contractor_first_name", with: "Von Christian"
      fill_in "contractor_last_name", with: "Halip"
      fill_in "contractor_company", with: "ITWORX"
      fill_in "contractor_position", with: "Proprietor"
      check "contractor_main_contractor"
      click_button "Save Contractor"

      expect(page).to have_content("updated successfully")
    end
  end
end
