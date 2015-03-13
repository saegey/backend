guard :rspec, cmd: 'bundle exec rspec' do
  watch('spec/spec_helper.rb')                        { "spec" }
  watch(%r{^config/(.*)\.rb$})                        { "spec" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.*)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^docs/schema/schemata/(.*)\.yaml$})        { |m| "spec/#{m[1].pluralize}_spec.rb" }
end

guard :bundler do
  watch('Gemfile')
end

guard 'rake', :task => 'schema' do
  watch(%r{^docs/schema/schemata/(.*)\.yaml$})
end
