require 'rails_helper'

feature "Inventory management" do
  context "when logged in " do
    before(:each) do
      user = create(:user, role: :supply_officer)
      login_as(user, scope: :user)
    end

    scenario "i can edit an inventory with valid information" do
      inventory = create(:inventory)
      visit supplies_inventories_path

      within("#edit_inventory") do
        click_on("Edit")
      end
      fill_in "Name", with: "Cement"
      fill_in "Unit", with: "bags"
      fill_in "Price", with: 90
      click_button "Save Inventory"

      expect(page).to have_content "updated successfully."
    end
  end
end
