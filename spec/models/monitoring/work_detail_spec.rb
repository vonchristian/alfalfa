require 'rails_helper'

RSpec.describe WorkDetail, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :project }
    it { is_expected.to have_many :work_accomplishments }
    it { is_expected.to have_many :time_extensions }
    it { is_expected.to have_many :amount_revisions }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :quantity }
    it do
      is_expected.to validate_numericality_of(:quantity).is_greater_than(0.1)
    end
    it { is_expected.to validate_presence_of :code }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :unit }
  end

  describe "delegations" do
    it { is_expected.to delegate_method(:cost).to(:project).with_prefix}
    it { is_expected.to delegate_method(:total).to(:time_extensions).with_prefix}
    it { is_expected.to delegate_method(:total).to(:amount_revisions).with_prefix}
  end

  it "#total" do
    work_detail1 = create(:work_detail, total_cost: 10 )
    work_detail2 = create(:work_detail, total_cost: 10 )
    expect(WorkDetail.total).to eql(20.0)
  end

  it ".slippage" do
    work_detail = create(:work_detail)
     
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
