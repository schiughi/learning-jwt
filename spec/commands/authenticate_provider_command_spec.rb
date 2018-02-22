require 'rails_helper'

RSpec.describe AuthenticateProviderCommand, type: :model do
  subject { described_class }
  let(:auth) { FactoryBot.build(:auth_hash) }
  let(:result) { subject.call(auth) }
  describe "::call" do
    context "when auth_hash does not have token, nickname" do
      let(:auth) { FactoryBot.build(:auth_hash, credentials: {}) }
      it "should be failure" do
        expect(result).to be_failure
      end
      it "return a message about the invalid" do
        expect(result.errors.messages[:auth]).to include I18n.t('activemodel.errors.models.authenticate_provider_command.attributes.auth.invalid')
      end
    end

    context "when social_profile already exists" do
      let! (:user) { FactoryBot.create(:user) }
      let! (:social_profile) { FactoryBot.create(:social_profile, provider: 'slack', uid: 'U3BPA937E', user: user) }
      it "should be success" do
        expect(result).to be_success
      end
      it "return the user token" do
        expect(JwtService.new.decode(result.token)[:user_id]).to eq user.id
      end
    end

    context "when social_profile is unregistered yet" do
      it "create new user account."
      it "return the encoded token"
    end
  end
end
