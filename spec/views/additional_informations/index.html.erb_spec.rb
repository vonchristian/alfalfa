require 'rails_helper'

RSpec.describe "additional_informations/index", type: :view do
  before(:each) do
    assign(:additional_informations, [
      AdditionalInformation.create!(
        :sex => "Sex",
        :birth_place => "Birth Place",
        :civil_status => "Civil Status",
        :nationality => "Nationality",
        :user => nil
      ),
      AdditionalInformation.create!(
        :sex => "Sex",
        :birth_place => "Birth Place",
        :civil_status => "Civil Status",
        :nationality => "Nationality",
        :user => nil
      )
    ])
  end

  it "renders a list of additional_informations" do
    render
    assert_select "tr>td", :text => "Sex".to_s, :count => 2
    assert_select "tr>td", :text => "Birth Place".to_s, :count => 2
    assert_select "tr>td", :text => "Civil Status".to_s, :count => 2
    assert_select "tr>td", :text => "Nationality".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
