# frozen_string_literal: true

require "gumroad"
require "vcr"
require 'webmock'
require "httparty"

GUMROAD_ACCESS_TOKEN = ENV["GUMROAD_ACCESS_TOKEN"] || '<ACCESS_TOKEN>'

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.filter_sensitive_data('<ACCESS_TOKEN>') { GUMROAD_ACCESS_TOKEN }
end

RSpec.configure do |config|

  Gumroad::Client.access_token = GUMROAD_ACCESS_TOKEN
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
