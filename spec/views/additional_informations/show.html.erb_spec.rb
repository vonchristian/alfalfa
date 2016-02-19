require 'rails_helper'

RSpec.describe "additional_informations/show", type: :view do
  before(:each) do
    @additional_information = assign(:additional_information, AdditionalInformation.create!(
      :sex => "Sex",
      :birth_place => "Birth Place",
      :civil_status => "Civil Status",
      :nationality => "Nationality",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sex/)
    expect(rendered).to match(/Birth Place/)
    expect(rendered).to match(/Civil Status/)
    expect(rendered).to match(/Nationality/)
    expect(rendered).to match(//)
  end
end
