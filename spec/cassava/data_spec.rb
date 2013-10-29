require_relative "../../lib/cassava/data"

describe Cassava::Data do
  let(:data) { described_class.new }

  describe "#add_column" do
    it "should add a column object" do
      data.add_column(:call, "header name")
      data.add_column(:call, "header name 2")
      data.columns.count.should eq 2
    end
  end

  describe "#add_row" do
    it "should add a row object" do
      data.add_row(double)
      data.add_row(double)
      data.rows.count.should eq 2
    end
  end

  describe "#add_rows" do
    it "should add everything from an array to rows" do
      data.add_rows( [double, double] )
      data.add_rows( [double] )
      data.rows.count.should eq 3
    end
  end

  describe "#headers" do
    subject { data.headers }
    context "with no columns" do
      let(:results) { Array.new }
      it { should eq(results) }
    end

    context "with column with header 'Foo'" do
      let(:results) { ["Foo"] }
      before { data.add_column(:foo, "Foo") }
      it { should eq(results) }
    end

    context "with columns with headers 'Foo', 'Bar'" do
      let(:results) { ["Foo", "Bar"] }
      before { data.add_column(:foo, "Foo") }
      before { data.add_column(:foo, "Bar") }
      it { should eq(results) }
    end
  end

  describe "#calls" do
    subject { data.calls }
    context "with no columns" do
      let(:results) { Array.new }
      it { should eq(results) }
    end

    context "with column with call 'Foo'" do
      let(:results) { [:foo] }
      before { data.add_column(:foo, "Foo") }
      it { should eq(results) }
    end

    context "with columns with calls :foo, :bar" do
      let(:results) { [:foo, :bar] }
      before { data.add_column(:foo, "Foo") }
      before { data.add_column(:bar, "Bar") }
      it { should eq(results) }
    end
  end
end
