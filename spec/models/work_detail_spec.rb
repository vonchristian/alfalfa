require 'rails_helper'

RSpec.describe WorkDetail, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :project }
    it { is_expected.to have_many :labor_costs }
    it { is_expected.to have_many :equipment_costs }
    it { is_expected.to have_many :issued_inventories }
    it { is_expected.to have_many :miscellaneous_costs }
    it { is_expected.to have_many :subcontract_costs }
    it { is_expected.to have_many :work_accomplishments }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of     :quantity }
    it { is_expected.to validate_presence_of     :code }
    it { is_expected.to validate_presence_of     :description }
    it { is_expected.to validate_numericality_of :quantity }
    it { is_expected.to validate_presence_of     :unit }
  end

  it ".name" do
    work_detail = create(:work_detail)

    expect(work_detail.name).to eql(work_detail.description)
  end

  it ".target_accomplishment_percent" do
  end

  it ".actual_accomplishment_percent" do
    work_detail = create(:work_detail, quantity: 100)
    work_accomplishment1 = create(:work_accomplishment, quantity: 10, work_detail: work_detail)
    work_accomplishment2 = create(:work_accomplishment, quantity: 10, work_detail: work_detail)

    expect(work_detail.actual_accomplishment_percent).to eql((20.0/100) * 100)
  end

  it ".weighted_percent" do
    project = create(:project, cost: 100)
    work_detail = create(:work_detail, total_cost: 20, project: project)

    expect(work_detail.weighted_percent).to eql( (20.0/100) *100 )
  end

  it ".accomplished_quantity" do
    work_detail = create(:work_detail, quantity: 100)
    work_accomplishment1 = create(:work_accomplishment, quantity: 10, work_detail: work_detail)
    work_accomplishment2 = create(:work_accomplishment, quantity: 10, work_detail: work_detail)

    expect(work_detail.accomplished_quantity).to eql(20)
  end

  it "#actual_total_costs" do
    work_detail = create(:work_detail, quantity: 100)
    issued_inventory = create(:issued_inventory, inventoriable: work_detail, total_cost: 1)
    labor_cost = create(:labor_cost, work_detail: work_detail, total_cost: 1)
    equipment_cost = create(:equipment_cost, work_detail: work_detail, total_cost: 1)
    miscellaneous_cost = create(:miscellaneous_cost, amount: 1, work_detail: work_detail)
    subcontract_cost = create(:subcontract_cost, amount: 1, work_detail: work_detail)

    expect(work_detail.actual_total_costs).to eql(5)
  end

  it "#remaining_quantity" do
    work_detail = create(:work_detail, quantity: 100)
    work_accomplishment1 = create(:work_accomplishment, quantity: 10, work_detail: work_detail)
    work_accomplishment2 = create(:work_accomplishment, quantity: 10, work_detail: work_detail)

    expect(work_detail.remaining_quantity).to eql(80)
  end

  it ".set_status_to_accomplished" do
    work_detail = create(:work_detail, quantity: 10 )
    work_accomplishment = create(:work_accomplishment, work_detail: work_detail, quantity: 10)
    work_detail.set_status_to_accomplished

    expect(work_detail.accomplished).to be true
  end
end
