require 'webmock/rspec'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed
end

def stub_failed_microsoft_request
  WebMock.reset!
  stub_request(:post, "https://api.cognitive.microsofttranslator.com/translate").
    with(
      query: {textType: "html", to: "de", 'api-version': "3.0"}
    ).
    to_return(status: 400, body: file_fixture("translation_failed.json").read)
end

def stub_successful_microsoft_request
  WebMock.reset!
  stub_request(:post, "https://api.cognitive.microsofttranslator.com/translate").
    with(
      query: {textType: "html", to: "de", 'api-version': "3.0"}
    ).
    to_return(status: 200, body: file_fixture("translation_successful.json").read)
end
