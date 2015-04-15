# This module encapsulates genomic coordinates.  When included in a class,
# the class will have a chromosome, left coord, right coord, and strand.
# The usual comparison operators are supported.
module Position
  include Comparable

  attr_reader :chrom, :left, :right, :strand

  @@chromPat = /^chr(\d+)(_\w+)?$/
  @@strandPat = /[+-.]/

  # Assign a chromosome.  Raises ArgumentError if no a string of some sort.
  def chrom=(c)
    # Can't predict what it migth look like, but must at least be a string
    if c.kind_of?(String)
      @chrom = c
    else
      raise ArgumentError, "Chrom '#{c}' is not a string"
    end
  end

  # Assign a left coordinate.
  # Raises ArgumentError if not some kind of integer.
  # Raises ArgumentError if @right is defined and is less than l.
  def left=(l)
    if not l.kind_of?(Integer)
      raise ArgumentError, "Left '#{l}' is not an integer"
    end
    if defined? @right and l > @right
      raise ArgumentError, "Left '#{l}' greater than right '#{@right}'"
    end
    @left = l
  end
     
  # Assign a right coordinate.
  # Raises ArgumentError if not some kind of integer.
  # Raises ArgumentError if @left is defined and is greater than r.
  def right=(r)
    if not r.kind_of?(Integer)
      raise ArgumentError, "Right '#{r}' is not an integer"
    end
    if defined? @left and @left > r
      raise ArgumentError, "Right '#{r}' less than left '#{@left}'"
    end
    @right = r
  end
     
  # Assign a strand.  Must be one of '+', '-', and '.' for "unknown".  Raises
  # ArgumentError otherwise.
  def strand=(s)
    if not @@strandPat =~ s
      raise ArgumentError, "Strand is '#{s}', should be '[+-.]'"
    end
    @strand = s
  end

  # The usual string method.
  def to_s
    return "#{@chrom}:#{@left}-#{@right}#{@strand=='.'?'':@strand}"
  end

  def chrCmp(other)
    smo = @@chromPat.match(@chrom)
    omo = @@chromPat.match(other.chrom)
    if smo != nil && omo != nil
      snum = smo[1].to_i
      onum = omo[1].to_i
      ccmp = snum <=> onum
      if ccmp == 0
        if smo[2] != nil
          if omo[2] != nil
            rv = smo[2] <=> omo[2]
          else
            rv = 1
          end
        elsif omo[2] != nil
          rv = -1
        else
          rv = 0
        end
      else
        rv = ccmp
      end
    elsif smo == nil
      rv = -1
    elsif omo == nil
      rv = 1
    else
      rv = @chrom <=> other
    end
    return rv
  end

  # The "spaceship" operator returns -1, 0, 1 as left is less than, equal to,
  # or greater than right.  Regarding strand, top strand is to the "left" of
  # bottom strand, which is to the left of "no strand".  (Completely arbitrary,
  # of course.)  The usual comparison operators are also supported
  # via inclusion of "Comparable".
  #
  # Chromsomes that are numbered are compared numerically (i.e. chr2 < chr11),
  # and if they have suffixes (i.e. chr6_hapXXX) then the 6 is compared
  # numerically but the suffix is compared lexicographically.  Other
  # chromosomes (e.g. chrX) are compared lexicographically (if *either*
  # operand is non-numeric, the comparison is lexicographic).
  def <=>(other)
    chr = chrCmp(other)
    if chr == 0
      l = @left <=> other.left
      if l == 0
        r = @right <=> other.right
        if r == 0
          rv = @strand <=> other.strand
        else
          rv = r
        end
      else
        rv = l
      end
    else 
      rv = chr
    end
    return rv
  end

  private :chrCmp

end
