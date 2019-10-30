# frozen_string_literal: true

require 'concurrent'

module Mooncell
  # @since 0.1.0
  # @api private
  class Configuration
    # @since 0.1.0
    # @api private
    def initialize(&block)
      @settings = Concurrent::Map.new
      instance_eval(&block)
    end

    # Set or get application protocol
    #
    # @param name [String|NilClass] the protocol name
    #
    # @since 0.1.0
    # @api private
    def protocol(name = nil)
      # TODO: Support multiple protocol each server
      return settings[:protocol] if name.nil?

      settings[:protocol] = name.to_s
    end

    # @since 0.1.0
    # @api private
    def apps
      settings.fetch_or_store(:apps, {})
    end

    # Set App
    #
    # @param application [Mooncell::Application] the application
    #
    # @since 0.1.0
    # @api private
    def app(app)
      apps[app.app_name] = app.new
    end

    private

    # @since 0.1.0
    # @api private
    attr_reader :settings
  end
end
