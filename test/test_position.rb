$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require "minitest/autorun"

require "bode/seq/position"

class PositionTest
  include Position

  def initialize(chr,left,right,strand=".")
    self.chrom = chr
    self.left = left
    self.right = right
    self.strand = strand
  end

end

class TestPosition < Minitest::Test

  def test_sanity
    x = PositionTest.new("chr1",1,10)
    assert_equal(x.chrom,"chr1")
  end

  def test_equality
    x = PositionTest.new("chr1",1,10)
    y = PositionTest.new("chr1",1,10)
    assert_equal(x,y)
  end

  def test_inequality
    x = PositionTest.new("chr1",1,10)
    y = PositionTest.new("chr1",1,11)
    assert_equal(x==y,false)
    y = PositionTest.new("chr2",1,10)
    assert_equal(x==y,false)
    y = PositionTest.new("chr1_Un1059129",1,10)
    assert_equal(x==y,false)
  end

  def test_spaceship
    p1 = PositionTest.new("chr1",1,10)
    p2 = PositionTest.new("chr1",1,20)
    assert_equal(p1 <=> p2,-1)
    p3 = PositionTest.new("chr2",1,10)
    p4 = PositionTest.new("chr11",1,10)
    assert_equal(p3 <=> p4,-1)
  end

#  def test_lt
#    assert_equal((Interval.new("chr1",1,10) < Interval.new("chr1",1,20)),true)
#  end

end
