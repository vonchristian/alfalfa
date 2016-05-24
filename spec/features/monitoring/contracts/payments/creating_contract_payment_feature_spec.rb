require 'rails_helper'

feature "Contract Payment management" do
  context "when logged in" do
    before(:each) do
      user = create(:user, role: :project_engineer)
      login_as(user, scope: :user)
    end

    scenario "then i can create a payment for a contract" do
      project = create(:project, cost: 1_000_000)
      contractor = create(:contractor, company: "Alfalfa")
      contract = create(:contract, project: project, contractor: contractor)
      visit monitoring_contract_path(contract)

      click_link "New Contract Payment"
      fill_in "Date", with: Time.zone.now
      fill_in "Reference number", with: "000111"
      fill_in "transactions_contractor_invoice_payment_debit_amounts_attributes_0_amount",  with: 100
      fill_in "Debit Account", with: "Accounts Payable"
      fill_in "transactions_contractor_invoice_payment_credit_amounts_attributes_0_amount", with: 100
      fill_in "Credit Account", with: "Cash on Hand"
      click_button "Record Payment"

      expect(page).to have_content("recorded successfully.")
    end
  end
end
