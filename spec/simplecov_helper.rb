require 'simplecov'
SimpleCov.start 'rails' do
  enable_coverage :branch
  add_filter '/spec/'
end
