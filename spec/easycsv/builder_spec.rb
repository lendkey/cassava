require_relative "../../lib/easycsv/builder"

describe EasyCSV::Builder do
  let(:builder) { described_class.new }

  describe "#wrapper" do
    subject { builder.wrapper }

    context "default" do
      it { should eq EasyCSV::DoubleQuoteWrapper }
    end

    context "setting a separator" do
      let(:wrapper) { Class.new }
      before { builder.wrapper = wrapper }
      it { should eq wrapper }
    end
  end

  describe "#separator" do
    subject { builder.separator }

    context "default" do
      it { should eq EasyCSV::ComaSeparator }
    end

    context "setting a separator" do
      let(:separator) { Class.new }
      before { builder.separator = separator }
      it { should eq separator }
    end
  end

  describe "#file_path" do
    subject { builder.file_path }

    context "with a path '~/csv.csv'" do
      before { builder.file_path = "~/csv.csv" }
      it { should eq "~/csv.csv" }
    end
  end

  describe "#generate" do
    let(:path) { "/tmp/test_file.csv" }
    let(:object_1) { double(foo: "Bar", herp: "Derp") }
    let(:object_2) { double(foo: "A", herp: "B") }
    let(:result) { "\"Foo\",\"Herp\"\n\"Bar\",\"Derp\"\n\"A\",\"B\"" }

    context "normal mode" do
      it "should return the sting of the csv" do
        builder.add_column(:foo, "Foo")
        builder.add_column(:herp, "Herp")
        builder.add_row(object_1)
        builder.add_row(object_2)

        builder.generate.should eq(result)
      end
    end

    context "block mode" do
      it "should return the sting of the csv" do
        b_object_1 = object_1
        b_object_2 = object_2

        described_class.generate do
          add_column(:foo, "Foo")
          add_column(:herp, "Herp")
          add_row(b_object_1)
          add_row(b_object_2)
        end.should eq(result)
      end
    end
  end

  describe "#build" do
    let(:path) { "/tmp/test_file.csv" }
    let(:object_1) { double(foo: "Bar", herp: "Derp") }
    let(:object_2) { double(foo: "A", herp: "B") }
    let(:result) { "\"Foo\",\"Herp\"\n\"Bar\",\"Derp\"\n\"A\",\"B\"" }

    after { `rm #{path}` }

    context "normal mode" do
      it "should write the file" do
        builder.file_path = path
        builder.add_column(:foo, "Foo")
        builder.add_column(:herp, "Herp")
        builder.add_row(object_1)
        builder.add_row(object_2)

        builder.build

        File.read(path).should eq(result)
      end
    end

    context "block mode" do
      it "should write the file" do
        b_path = path
        b_object_1 = object_1
        b_object_2 = object_2

        described_class.build do
          set_path(b_path)
          add_column(:foo, "Foo")
          add_column(:herp, "Herp")
          add_row(b_object_1)
          add_row(b_object_2)
        end

        File.read(b_path).should eq(result)
      end
    end
  end
end
