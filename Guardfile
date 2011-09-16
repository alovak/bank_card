# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', 
      :version => 2, 
      :cli => "--color --format nested", 
      :all_after_pass => false, 
      :all_on_start => false,
      :keep_failed => false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { "spec/" }
  watch('spec/spec_helper.rb')  { "spec/" }
end


guard 'bundler' do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end
