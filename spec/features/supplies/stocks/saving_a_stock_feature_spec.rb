require 'rails_helper'

RSpec.feature "Saving a stock" do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :supply_officer)
      login_as(user, scope: :user)
    end

    scenario "then i can save a  stock with valid information" do
      inventory = create(:inventory)
      visit supplies_inventory_path(inventory)
      click_link "New Stock"

      fill_in "Date", with: Time.zone.now
      fill_in "Quantity", with: 40

      click_button "Save Stock"

      expect(page).to have_content "saved successfully."
    end
  end
end
