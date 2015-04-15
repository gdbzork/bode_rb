# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bode/version"

Gem::Specification.new do |s|
  s.name        = 'bode'
  s.version     = Bode::VERSION
  s.date        = '2015-02-18'
  s.summary     = "Bioinformatics ODds and Ends in Ruby"
  s.description = "Various odds and ends of code for bioinformatics"
  s.authors     = ["Gord Brown"]
  s.email       = 'gdbzork@gmail.com'
  s.files       = ["lib/bode.rb","lib/bode/seq.rb"]
  s.require_paths = ["lib"]
  s.license       = 'MIT'
end
