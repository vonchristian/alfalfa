require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.feature "Project management", type: :feature  do
  context "when logged in" do

    before(:each) do
      admin = create(:user)
      login_as(admin , :scope => :user)
    end

    scenario "then i can see the project index page" do
      project1 = create(:project, name: 'Road')
      project2 = create(:project, name: 'Building')

      visit projects_path
      expect(page.body).to     have_content 'ROAD'
       expect(page.body).to    have_content 'BUILDING'
    end

    scenario "then i can save a project" do
      visit projects_path
      click_link "Add Project"

      click_on 'Save Project'

    expect(page).to have_content "blank"
    end
  end
end
