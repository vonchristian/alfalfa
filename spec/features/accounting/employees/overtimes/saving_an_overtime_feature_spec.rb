require 'rails_helper'

RSpec.feature "Overtime management" do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :accounting_officer)
      login_as(user, scope: :user)
    end
    scenario "then i can save an overtime with valid information" do
      employee = create(:employee)
      visit employee_path(employee)
      click_link "Add Overtime"
      fill_in "Number of hours", with: 1
      fill_in "Start date", with: Time.zone.now.beginning_of_month
      fill_in "End date", with: Time.zone.now.end_of_month

      click_button "Save Overtime"

      expect(page).to have_content "saved successfully."

    end
  end
end
