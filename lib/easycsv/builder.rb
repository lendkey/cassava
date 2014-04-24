require_relative "data"

module EasyCSV
  class Builder
    attr_accessor :wrapper, :separator, :file_path, :data
    def self.build(&block)
      builder = new
      builder.instance_eval(&block)
      builder.build
    end

    def self.generate(&block)
      builder = new
      builder.instance_eval(&block)
      builder.generate
    end

    def initialize
      @data = Data.new
      @wrapper = DoubleQuoteWrapper
      @separator = CommaSeparator
    end

    def generate
      [header_row, data_rows].inject(String.new) do |str, part|
        str += part
      end
    end

    def build
      File.open(@file_path, "w") do |f|
        f.write self.generate
      end
    end

    def set_column_separator(separator)
      @separator = separator
    end

    def set_path(path)
      @file_path = path
    end

    def method_missing(m, *args, &block)
      @data.send(m, *args, &block)
    end

    private

    def header_row
      separate( wrap(@data.headers) ) + "\n"
    end

    def data_rows
      @data.rows.map{|r| build_row(r)}.join "\n"
    end

    def build_row(r)
      row = @data.calls.map{|c| r.send(c)}
      separate( wrap(row) )
    end

    def wrap(row)
      @wrapper.new(row).wrap
    end

    def separate(row)
      @separator.new(row).separate
    end
  end
end
