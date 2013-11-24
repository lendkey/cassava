require_relative '../../lib/cassava/double_quote_wrapper'

describe Cassava::DoubleQuoteWrapper do
  describe "#wrap" do
    subject { described_class.new(row).wrap }
    let(:row) { ["entry", "yrtne"] }

    context 'given an array ["entry", "yrtne"]' do
      let(:result) { ["\"entry\"", "\"yrtne\""] }

      it { should eq(result) }
    end
  end
end
