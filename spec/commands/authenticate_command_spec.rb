require 'rails_helper'

RSpec.describe AuthenticateCommand, type: :model do
  subject { described_class }
  let(:username) { "hoge" }
  let(:password) { "hoge11111" }
  let(:result) { subject.call(username: username, password: password) }
  describe "::call" do
    context "when the user is unregistered" do
      it "failure" do
        expect(result).to be_failure
      end

      it "return a message about unregistered" do
        expect(result.errors.full_messages).to include I18n.t('activemodel.errors.messages.unregistered_user')
      end
    end

    context "when the user's password is incorrect" do
      let!(:user) { FactoryBot.create(:user , username: username) }
      it "failure" do
        expect(result).to be_failure
      end

      it "return a message about invalid credentials" do
        expect(result.errors.full_messages).to include I18n.t('activemodel.errors.messages.invalid_credentials')
      end
    end

    context "when the password and the name is matched" do
      let!(:user) { FactoryBot.create(:user , username: username, password: password, password_confirmation: password) }
      it "success" do
        expect(result).to be_success
      end

      it "return a encoded token" do
        expect(result.token).to be_present
      end
    end
  end
end
