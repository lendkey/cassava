require "delegate"

module Cassava
  class Data < Struct.new(:columns, :rows)
    def initialize
      super(Array.new, Array.new)
    end

    def headers
      columns.map(&:header_name)
    end

    def calls
      columns.map(&:method_call)
    end

    def add_column(header_name, method_call)
      columns.push(Column.new(header_name, method_call))
    end

    def add_row(data_model)
      rows.push(Row.new(data_model))
    end

    def add_rows(data_models)
      data_models.each{|d| add_row(d)}
    end
  end

  Column = Struct.new(:method_call, :header_name)
  class Row < SimpleDelegator; end
end
