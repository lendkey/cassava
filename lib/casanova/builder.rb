require "delegate"
module Casanova
  class Builder
    attr_accessor :column_separator, :columns, :file_path, :rows
    def initialize
      @column_separator = ","
      @columns = Array.new
      @rows = Array.new
    end

    def self.build(&block)
      builder = new
      delegator = BlockDelegator.new(builder)
      delegator.instance_eval(&block)
      builder.build
    end

    def add_column(header_name, method_call)
      columns.push(Column.new(header_name, method_call))
    end

    def add_row(data_model)
      @rows.push(Row.new(data_model))
    end

    def add_rows(data_models)
      @rows = data_models.map{|d| Row.new(d)} + @rows
    end

    def set_path(path)
      @file_path = path
    end

    def build
      File.open(@file_path, "w") do |f|
        f.write header_row
        f.write data_rows
      end
    end

    private

    def header_row
      columns.map(&:header_name).join(@column_separator) + "\n"
    end

    def data_rows
      rows.map{|r| build_row(r)}.join "\n"
    end

    def build_row(r)
      row = []
      columns.each do |c|
        row << r.send(c.method_call)
      end
      row.join @column_separator
    end
  end

  Column = Struct.new(:method_call, :header_name)
  class Row < SimpleDelegator; end
  class BlockDelegator < SimpleDelegator;end
end
