require "bode/seq/position"

class Interval

  include Position

  attr_accessor :name

  def initialize(chr,left,right,strand=".",name=nil)
    self.chrom = chr
    self.left = left
    self.right = right
    self.strand = strand
    @name = name
  end

end
