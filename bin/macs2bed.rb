#!/usr/bin/env ruby

require 'optparse'

################################################################################
# parse options

opts = {"histone" => false}
oparse = OptionParser.new do |optobj|
  optobj.on("-h","--histone","Parse a histone-formatted file") do 
    opts["histone"] = true
  end
end.parse!
  
################################################################################

inFN = ARGV[0]
outFN = ARGV[1]

inFD = File.new(inFN)
outFD = File.new(outFN,"w")
scoreCol = 6
scoreCol = 5 if opts["histone"]
lines = 0
inFD.each do |line|
  next if line[0] == '#'
  flds = line.split
  next if flds[0] == "chr" || flds[0] == nil
  lines += 1
  score = (flds[scoreCol].to_f + 0.5).to_i
  outFD.puts "#{flds[0]}\t#{flds[1]}\t#{flds[2]}\tpeak#{lines}\t#{score}\t+"
end
inFD.close
outFD.close
puts "lines: #{lines}"
