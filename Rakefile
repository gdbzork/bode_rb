require "bundler/gem_tasks"
require "rake/testtask"
require "rdoc/task"

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.warning = true
  t.verbose = true
  t.test_files = FileList['test/test_*.rb']
end

Rake::RDocTask.new do |rd|
  rd.main = "docmain.rdoc"
  rd.rdoc_files.include("docmain.rdoc","lib/**/*.rb")
end
