#!/usr/bin/env ruby

require 'optparse'

################################################################################
# parse options

opts = {"width" => 300}
oparse = OptionParser.new do |optobj|
  optobj.on("-h","--histone","Parse a histone-formatted file") do 
    opts["width"] = nil
  end
  optobj.on("-wNNN","--width=NNN",Integer,"width of factor peaks") do |w|
    opts["width"] = w
  end
end.parse!
  
################################################################################

inFN = ARGV[0]
outFN = ARGV[1]

inFD = File.new(inFN)
outFD = File.new(outFN,"w")
lines = 0
inFD.each do |line|
  lines += 1
  next if line[0] == '#'
  flds = line.split
  if opts["width"]
    m = (flds[2].to_i + flds[3].to_i) / 2
    f = opts["width"] / 2
    l = m - f
    r = m + f + 1
  else
    l = flds[2].to_i
    r = flds[3].to_i
  end
  outFD.puts "#{flds[1]}\t#{l}\t#{r}\t#{flds[0]}\t#{flds[7].to_i}\t#{flds[4]}"
end
inFD.close
outFD.close
puts "lines: #{lines}"
