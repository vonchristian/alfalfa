require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations" do 
    it {is_expected.to validate_presence_of :name }
    it {is_expected.to validate_presence_of :id_number }
    it {is_expected.to validate_presence_of :duration }
    it {is_expected.to validate_presence_of :cost }
    it {is_expected.to validate_presence_of :address}
  end

  describe "associations" do 
    it {is_expected.to have_one :notice_to_proceed }
    it {is_expected.to belong_to :main_contractor }
    it {is_expected.to belong_to :category }

    it {is_expected.to have_many :expenses }
    it {is_expected.to have_many :bids }
    it {is_expected.to have_many :billings }
    it {is_expected.to have_many :contracts }
    it {is_expected.to have_many :contractors }
    it {is_expected.to have_many :time_extensions }
    it {is_expected.to have_many :amount_revisions }
    it {is_expected.to have_many :accomplishments }
    it {is_expected.to have_many :remarks }
  end
  describe "#slippage" do
    before(:each) do 
      
    end
    it "returns zero if notice to proceed is not yet awarded" do 
      project = create(:project, notice_to_proceed: nil )

      expect(project.slippage).to eql(0)
    end

    it "positive for actual accomplishment is greater than target accomplishment" do 
       project = create(:project, duration: 60)
       notice_to_proceed = create(:notice_to_proceed, date: Time.zone.now, project: project)
       accomplishment = create(:accomplishment, percent: 2, project: project)

       expect(project.slippage).to be_positive
    end

     it "returns negative slippage if accomplishments is less than the percent of actual accomplishments" do 
       project = create(:project, duration: 60)
       notice_to_proceed = create(:notice_to_proceed, date: (Time.zone.now - 10.days), project: project)
       accomplishment = create(:accomplishment, percent: 2, project: project)

       expect(project.slippage).to be_negative
    end
  end

  describe "days elapsed" do 
    it "returns 0 days if notice to proceed is awarded today" do 
      project = create(:project, duration: 60, created_at: Time.zone.now )
      notice_to_proceed = create(:notice_to_proceed, date: (Time.zone.now ), project: project)

      expect(project.days_elapsed).to eql(0)
    end

     it "returns -10 days if notice to proceed is awarded 10 days from now" do 
      project = create(:project, duration: 60, created_at: Time.zone.now )
      notice_to_proceed = create(:notice_to_proceed, date: (Time.zone.now + 10.days ), project: project)

      expect(project.days_elapsed).to eql(-10)
    end

    it "returns  -1 day if notice to proceed is awarded 1 days from now" do 
      project = create(:project, duration: 60, created_at: Time.zone.now )
      notice_to_proceed = create(:notice_to_proceed, date: (Time.zone.now  + 1.days ), project: project)

      expect(project.days_elapsed).to eql(-1)
    end

    it "returns  10 days if notice to proceed is awarded 10 days ago" do 
      project = create(:project, duration: 60, created_at: Time.zone.now )
      notice_to_proceed = create(:notice_to_proceed, date: (Time.zone.now), project: project)
     
        travel_to(10.day.from_now) do
      expect(project.days_elapsed).to eql(10)
    end
    end
  end

  describe "expiry date" do 
    it "the date is equal to the date NTP is awarded plus duration of the project" do
      project = create(:project, duration: 60, created_at: Time.zone.now.beginning_of_year)
      notice_to_proceed = create(:notice_to_proceed, date: (Time.zone.now.beginning_of_year + 15.days), project: project)

      expect(project.expiry_date.to_date).to eql((notice_to_proceed.date + 60.days).to_date)
    end
  end

  describe "#actual_accomplishment" do 
    it "is zero if no for new project" do 
      project = create(:project)

      expect(project.actual_accomplishment).to be(0)
    end

    it ".total" do 
      project = create(:project)
      accomplishment1 = create(:accomplishment, percent: 2, project: project)
      accomplishment2 = create(:accomplishment, percent: 2, project: project)

      expect(project.actual_accomplishment).to eql(4.0)
     
end
   end

   describe "contract cost" do
   it "returns the original contract cost if no amount amount_revisions" do 
      project = create(:project, cost: 1_000_000)

      expect(project.revised_contract_amount).to eql(1_000_000.0)
   end 

   it ".revised_contract_amount" do 
      project = create(:project, cost: 1_000_000)
      amount_revision = create(:amount_revision, amount: 10_000, project: project)


      expect(project.revised_contract_amount).to eql(1_010_000.0)
   end 
   end
end

