require 'rails_helper'

feature "Inventory management" do
  context "when logged in " do
    before(:each) do
      user = create(:user, role: :supply_officer)
      login_as(user, scope: :user)
    end

    scenario "i can save an inventory with valid information" do
      visit supplies_inventories_path
      click_link "New Inventory"
      fill_in "Name", with: "Cement"
      fill_in "Date", with: Time.zone.now
      fill_in "Quantity", with: 100
      fill_in "Unit", with: 'bags'
      fill_in "Price", with: 250

      click_button "Save Inventory"

      expect(page).to have_content "saved successfully."
    end
  end
end
