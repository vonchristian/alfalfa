require 'rails_helper'

describe ProjectDetails::NoticeToProceed, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :project }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :date }

    context "of date" do
      let(:date) { Time.zone.now }
      let(:project) { build(:project, created_at: date)}
      subject { ProjectDetails::NoticeToProceed.new(date: date, project: project) }

      it "must be on or after the date a project was created" do
        is_expected.not_to allow_value(date - 1.day).for(:date)
        is_expected.to allow_value(date).for(:date)
        should allow_value(date + 1.day).for(:date)
      end
    end
  end

  describe "delegations" do
    it { is_expected.to delegate_method(:created_at).to(:project).with_prefix }
  end
end
