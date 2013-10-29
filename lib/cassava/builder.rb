require_relative "data"

module Cassava
  class Builder
    attr_accessor :column_separator, :file_path, :data
    def self.build(&block)
      builder = new
      builder.instance_eval(&block)
      builder.build
    end

    def initialize
      @column_separator = ','
      @data = Data.new
    end

    def build
      File.open(@file_path, "w") do |f|
        f.write header_row
        f.write data_rows
      end
    end

    def set_column_separator(separator)
      @column_separator = separator
    end

    def set_path(path)
      @file_path = path
    end

    def method_missing(m, *args, &block)
      @data.send(m, *args, &block)
    end

    private

    def header_row
      @data.headers.join(@column_separator) + "\n"
    end

    def data_rows
      @data.rows.map{|r| build_row(r)}.join "\n"
    end

    def build_row(r)
      row = @data.calls.map{|c| r.send(c)}
      row.join @column_separator
    end
  end
end
