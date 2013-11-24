require_relative '../../lib/cassava/coma_separator'

describe Cassava::ComaSeparator do
  describe '#separate' do
    subject { described_class.new(row).separate }
    let(:row) { ['Foo', 'Bar'] }

    context "given an array ['Foo', 'Bar']" do
      let(:result) { "Foo,Bar" }

      it { should eq(result) }
    end
  end
end
