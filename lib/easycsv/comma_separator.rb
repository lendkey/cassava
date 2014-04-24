module EasyCSV; class CommaSeparator; end; end

class EasyCSV::CommaSeparator
  def initialize(row)
    @row = row
  end

  def separate
    @row.join(',')
  end
end
