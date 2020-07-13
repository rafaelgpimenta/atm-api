require "rails_helper"

RSpec.describe V1::AccountsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/accounts").to route_to("v1/accounts#index")
    end

    it "routes to #show" do
      expect(get: "/v1/accounts/1").to route_to("v1/accounts#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/accounts").to route_to("v1/accounts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/accounts/1").to route_to("v1/accounts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/accounts/1").to route_to("v1/accounts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/accounts/1").to route_to("v1/accounts#destroy", id: "1")
    end
  end
end
