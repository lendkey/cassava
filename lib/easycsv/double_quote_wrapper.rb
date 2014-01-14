module EasyCSV; class DoubleQuoteWrapper; end; end

class EasyCSV::DoubleQuoteWrapper
  def initialize(row)
    @row = row
  end

  def wrap
    @row.map{|e| "\"#{e}\""}
  end
end
