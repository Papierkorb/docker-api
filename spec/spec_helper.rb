$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'
require 'rspec/its'
require 'simplecov'
require 'docker'

ENV['DOCKER_API_USER']  ||= 'debbie_docker'
ENV['DOCKER_API_PASS']  ||= '*************'
ENV['DOCKER_API_EMAIL'] ||= 'debbie_docker@example.com'

RSpec.shared_context "local paths" do
  def project_dir
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.color = true
  config.formatter = :documentation
  config.tty = true

  case ENV['DOCKER_VERSION']
  when /1\.6/
    config.filter_run_excluding :docker_1_8 => true
    config.filter_run_excluding :docker_1_9 => true
  when /1\.7/
    config.filter_run_excluding :docker_1_8 => true
    config.filter_run_excluding :docker_1_9 => true
  when /1\.8/
    config.filter_run_excluding :docker_1_9 => true
  end
end
