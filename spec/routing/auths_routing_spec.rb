require "rails_helper"

RSpec.describe AuthsController, type: :routing do
  describe "routing" do
    it "routes to #sign_up" do
      expect(post: "/sign_up").to route_to("auths#sign_up")
    end

    it "routes to #sign_in" do
      expect(post: "/sign_in").to route_to("auths#sign_in")
    end

    it "routes to #sign_out" do
      expect(post: "/sign_out").to route_to("auths#sign_out")
    end

    it "routes to #refresh" do
      expect(post: "/refresh").to route_to("auths#refresh")
    end
  end
end
