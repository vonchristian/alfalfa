require "rails_helper"

RSpec.describe AdditionalInformationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/additional_informations").to route_to("additional_informations#index")
    end

    it "routes to #new" do
      expect(:get => "/additional_informations/new").to route_to("additional_informations#new")
    end

    it "routes to #show" do
      expect(:get => "/additional_informations/1").to route_to("additional_informations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/additional_informations/1/edit").to route_to("additional_informations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/additional_informations").to route_to("additional_informations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/additional_informations/1").to route_to("additional_informations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/additional_informations/1").to route_to("additional_informations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/additional_informations/1").to route_to("additional_informations#destroy", :id => "1")
    end

  end
end
