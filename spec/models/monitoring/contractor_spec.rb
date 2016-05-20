require 'rails_helper'

RSpec.describe Contractor, type: :model do
  describe "associations" do
    it { is_expected.to have_many :contracts }
    it { is_expected.to have_many :projects }
    it { is_expected.to have_many :orders }
    it { is_expected.to have_many :line_items }
  end
  describe "validations" do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :company }
    it { is_expected.to validate_presence_of :position }
  end

  it ".full_name" do
    contractor = create(:contractor, first_name: "Von Christian", last_name: "Halip")

    expect(contractor.full_name).to eql("Von Christian Halip")
  end

  it ".name" do
    contractor = create(:contractor, first_name: "Von Christian", last_name: "Halip")

    expect(contractor.name).to eql("Von Christian Halip")
  end
  it ".to_s" do
    contractor = create(:contractor, company: "Alfalfa")

    expect(contractor.to_s).to eql("Alfalfa")
  end
 
  describe "photo attachment" do
    it { should have_attached_file(:profile_photo) }
    it { should validate_attachment_content_type(:profile_photo).
               allowing('image/png', 'image/gif').
               rejecting('text/plain', 'text/xml') }
  end
  describe '.main_contractors' do
    let(:main_contractor) { create(:contractor, main_contractor: true) }
    let(:sub_contractor) { create(:contractor, main_contractor: false) }
    let(:main_contractors) { Contractor.main_contractors }

    it 'returns main contractors' do
      expect(main_contractors).to include(main_contractor)
      expect(main_contractors).to_not include(sub_contractor)
    end
  end
  describe '.sub_contractors' do
    let(:main_contractor) { create(:contractor, main_contractor: true) }
    let(:sub_contractor) { create(:contractor, main_contractor: false) }
    let(:sub_contractors) { Contractor.sub_contractors }

    it 'returns main contractors' do
      expect(sub_contractors).to include(sub_contractor)
      expect(sub_contractors).to_not include(main_contractor)
    end
  end
end
