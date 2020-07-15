require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "Validations" do
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_presence_of(:balance) }
  end

  describe "Associations" do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
  end
end
