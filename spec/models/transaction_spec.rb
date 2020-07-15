require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "Validations" do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe "Associations" do
    it { is_expected.to belong_to(:account) }
  end

  describe "Attributes" do
    it { is_expected.to define_enum_for(:kind).with_values([:withdraw, :deposit]) }
  end
end
