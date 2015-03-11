# Rakefile
require 'prmd/rake_tasks/combine'
require 'prmd/rake_tasks/verify'
require 'prmd/rake_tasks/doc'

namespace :schema do
  Prmd::RakeTasks::Combine.new do |t|
    t.options[:meta] = 'docs/schema/meta.json'    # use meta.yml if you prefer YAML format
    t.paths << 'docs/schema/schemata'
    t.output_file = 'docs/schema.json'
  end

  Prmd::RakeTasks::Verify.new do |t|
    t.files << 'docs/schema.json'
  end

  Prmd::RakeTasks::Doc.new do |t|
    t.files = { 'docs/schema.json' => 'docs/schema.md' }
  end
end

task schema: ['schema:combine', 'schema:verify', 'schema:doc']
