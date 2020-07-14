require "rails_helper"

RSpec.describe V1::TransactionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/transactions").to route_to("v1/transactions#index")
    end

    it "routes to #show" do
      expect(get: "/v1/transactions/1").to route_to("v1/transactions#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/transactions").to route_to("v1/transactions#create")
    end
  end
end
