module Cassava; class ComaSeparator; end; end

class Cassava::ComaSeparator
  def initialize(row)
    @row = row
  end

  def separate
    @row.join(',')
  end
end
