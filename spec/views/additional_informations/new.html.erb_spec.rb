require 'rails_helper'

RSpec.describe "additional_informations/new", type: :view do
  before(:each) do
    assign(:additional_information, AdditionalInformation.new(
      :sex => "MyString",
      :birth_place => "MyString",
      :civil_status => "MyString",
      :nationality => "MyString",
      :user => nil
    ))
  end

  it "renders new additional_information form" do
    render

    assert_select "form[action=?][method=?]", additional_informations_path, "post" do

      assert_select "input#additional_information_sex[name=?]", "additional_information[sex]"

      assert_select "input#additional_information_birth_place[name=?]", "additional_information[birth_place]"

      assert_select "input#additional_information_civil_status[name=?]", "additional_information[civil_status]"

      assert_select "input#additional_information_nationality[name=?]", "additional_information[nationality]"

      assert_select "input#additional_information_user_id[name=?]", "additional_information[user_id]"
    end
  end
end
