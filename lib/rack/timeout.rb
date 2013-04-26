# encoding: utf-8
raise 'ruby ≥ 1.9.1 required.' if RUBY_PLATFORM != 'java' && RUBY_VERSION < '1.9.1'
require 'timeout'

module Rack
  class Timeout
    class Error < ::Timeout::Error; end

    @timeout = 15
    class << self
      attr_accessor :timeout
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      ::Timeout.timeout(self.class.timeout, ::Rack::Timeout::Error) { @app.call(env) }
    end

  end
end
