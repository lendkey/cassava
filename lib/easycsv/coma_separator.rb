module EasyCSV; class ComaSeparator; end; end

class EasyCSV::ComaSeparator
  def initialize(row)
    @row = row
  end

  def separate
    @row.join(',')
  end
end
