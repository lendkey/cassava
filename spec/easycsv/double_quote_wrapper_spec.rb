require_relative '../../lib/easycsv/double_quote_wrapper'

describe EasyCSV::DoubleQuoteWrapper do
  describe "#wrap" do
    subject { described_class.new(row).wrap }
    let(:row) { ["entry", "yrtne"] }

    context 'given an array ["entry", "yrtne"]' do
      let(:result) { ["\"entry\"", "\"yrtne\""] }

      it { should eq(result) }
    end
  end
end
