class IntervalFile

  @@suffixToFormat = {
    "bed" => "thing"
  }

  attr_accessor :name

def IntervalFile.getType(fname)
  
