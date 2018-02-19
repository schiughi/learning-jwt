require 'rails_helper'

RSpec.describe JwtService, type: :model do
  subject { JwtService.new }
  let(:payload) do
    HashWithIndifferentAccess.new({ one: 'two' })
  end
  let(:token) { subject.encode(payload) }

  describe "#decode" do
    it "should equals payload" do
      expect(subject.decode(token)).to eq payload
    end
  end
end
