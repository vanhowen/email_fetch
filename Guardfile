# More info at https://github.com/guard/guard#readme

guard 'rspec',
  cli: "--color --format nested --fail-fast --drb",
  all_after_pass: false, all_on_start: false, spec_paths: ['spec'] do

  # Main app.
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb') { "spec" }
  watch(%r{^lib/(.+)\.rb$}) { "spec" }
end
