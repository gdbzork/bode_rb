$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require "minitest/autorun"

require "bode/seq"

class TestSeq < Minitest::Test

  def test_sanity
    x = Interval.new("chr1",1,10)
    assert_equal(x.chrom,"chr1")
  end

  def test_equality
    x = Interval.new("chr1",1,10)
    y = Interval.new("chr1",1,10)
    assert_equal(x,y)
  end

  def test_inequality
    x = Interval.new("chr1",1,10)
    y = Interval.new("chr1",1,11)
    assert_equal(x==y,false)
  end

  def test_spaceship
    assert_equal((Interval.new("chr1",1,10) <=> Interval.new("chr1",1,20)),-1)
    assert_equal((Interval.new("chr2",1,10) <=> Interval.new("chr11",1,10)),-1)
  end

  def test_lt
    a = Interval.new("chr1",1,10)
    b = Interval.new("chr1",1,20)
    puts a
    puts b
    x = a < b
    assert_equal(x,true)
  end

end
