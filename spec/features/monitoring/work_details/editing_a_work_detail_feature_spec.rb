require 'rails_helper'

RSpec.feature "Editing a work detail", type: :feature do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :project_engineer)
      login_as(user , :scope => :user)
    end
    scenario "then i can edita work_detail" do
      project = create(:project)
      work_detail = create(:work_detail, project: project)
      visit monitoring_work_detail_path(work_detail)
      click_link "Update"

      fill_in "Code", with: "34423"
      fill_in "Description", with: "Safety Program"
      fill_in "Unit", with: "cu.m"
      fill_in "Unit cost", with: 100
      fill_in "Quantity", with: 1
      fill_in "Total cost", with: 100

      click_button "Update Work Detail"

    expect(page).to have_content "updated successfully."
    end
  end
end
 
