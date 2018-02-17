require 'rails_helper'

RSpec.describe DecodeAuthenticationCommand, type: :model do
  subject { described_class }
  let(:token) { nil }
  let(:headers) do
    { "Authorization" => "base #{token}" }
  end
  let(:result) { subject.call(headers) }
  describe "::call" do
    context "when headers is absent" do
      let(:headers) { nil }
      it "failure" do
        expect(result).to be_failure
      end

      it "return a message about token missing" do
        expect(result.errors.messages[:token]).to include I18n.t('activemodel.errors.models.decode_authentication_command.attributes.token.token_missing')
      end
    end

    context "when authorization is absent" do
      let(:headers) do
        {}
      end
      it "failure" do
        expect(result).to be_failure
      end

      it "return a message about token missing" do
        expect(result.errors.messages[:token]).to include I18n.t('activemodel.errors.models.decode_authentication_command.attributes.token.token_missing')
      end
    end

    context "when token is absent" do
      let(:headers) do
        {}
      end
      it "failure" do
        expect(result).to be_failure
      end

      it "return a message about token missing" do
        expect(result.errors.messages[:token]).to include I18n.t('activemodel.errors.models.decode_authentication_command.attributes.token.token_missing')
      end
    end

    context "when the token is valid" do
      let!(:user) { FactoryBot.create(:user) }
      let(:token) do
        JwtService.new.encode(user_id: user.id, exp: 24.hours.from_now.to_i)
      end
      it "success" do
        expect(result).to be_success
      end

      it "return current user" do
        expect(result.user).to eq user
      end
    end
  end
end
