require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Validations" do
    subject { FactoryBot.create(:customer) }
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }
  end

  describe "Associations" do
    it { is_expected.to have_one(:account).dependent(:destroy) }
    it { is_expected.to have_many(:transactions).through(:account) }
  end
end
