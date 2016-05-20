require 'rails_helper'

feature "Work Detail management", type: :feature  do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :project_engineer)
      login_as(user , :scope => :user)
    end
    scenario "then i can save a work_detail" do
      project = create(:project)
      visit monitoring_project_path(project)
      click_link "Add New Work Detail"

      fill_in "Code", with: "34423"
      fill_in "Description", with: "Safety Program"
      fill_in "Unit", with: "cu.m"
      fill_in "Unit Cost", with: 100
      fill_in "Quantity", with: 1
      fill_in "Total Cost", with: 100

      click_button "Save Work Detail"

    expect(page).to have_content "saved successfully."
    end
  end
end
