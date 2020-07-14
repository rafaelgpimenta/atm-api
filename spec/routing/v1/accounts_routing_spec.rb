require "rails_helper"

RSpec.describe V1::AccountsController, type: :routing do
  describe "routing" do
    it "routes to #my" do
      expect(get: "/v1/accounts/my").to route_to("v1/accounts#my")
    end
  end
end
