module Cassava; class DoubleQuoteWrapper; end; end

class Cassava::DoubleQuoteWrapper
  def initialize(row)
    @row = row
  end

  def wrap
    @row.map{|e| "\"#{e}\""}
  end
end
