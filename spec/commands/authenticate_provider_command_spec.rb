require 'rails_helper'

RSpec.describe AuthenticateProviderCommand, type: :model do
  subject { described_class }
  let(:auth) { FactoryBot.build(:auth_hash) }
  describe "::call" do
    context "when auth_hash does not have token, nickname" do
      it "should be invalid"
    end

    context "when social_profile already exists" do
      it "return the encoded token"
    end

    context "when social_profile is unregistered yet" do
      it "create new user account."
      it "return the encoded token"
    end
  end
end
