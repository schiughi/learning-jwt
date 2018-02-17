require 'rails_helper'

RSpec.describe JwtService, type: :model do
  subject { JwtService.new }
  let(:payload) do
    HashWithIndifferentAccess.new({ one: 'two' })
  end
  # this is dependent on 'config/secrets.yml'
  let(:token) { 'eyJhbGciOiJIUzI1NiJ9.eyJvbmUiOiJ0d28ifQ.g4BMJ85SWt6u4z3ysDFkKxqY8nxlk9l-LjFV5QCddpo' }

  describe "#encode" do
    it { expect(subject.encode(payload)).to eq token }
  end

  describe "#decode" do
    it { expect(subject.decode(token)).to eq payload }
  end
end
