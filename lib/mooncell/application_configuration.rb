# frozen_string_literal: true

require 'concurrent'

module Mooncell
  # The Application Configruation
  #
  # @since 0.1.0
  # @api private
  class ApplicationConfiguration
    # Create new configuration
    #
    # @param block [Proc] the configuration block
    #
    # @since 0.1.0
    # @api private
    def initialize(&block)
      @settings = {}
      instance_eval(&block)
    end

    # Protocol
    #
    # @overload protocol
    #   Get the protocol
    #   @return [String] the protocol
    #
    # @overload protocol(value)
    #   Set the protocol
    #   @param protocol [String] the target protocol
    #
    # @since 0.1.0
    # @api private
    def protocol(value = nil)
      if value
        settings[:protocol] = value.to_s
      else
        settings[:portocol] || Mooncell.configuration.protocol
      end
    end

    # Port
    #
    # @overload port
    #   Get the port
    #   @return [Number] the port
    #
    # @overload port(value)
    #   Set the port
    #   @param port [Number] the port
    #
    # @since 0.1.0
    # @api private
    def port(value = nil)
      return settings[:port] if value.nil?

      settings[:port] = value.to_i
    end

    private

    # @since 0.1.0
    # @api private
    attr_reader :settings
  end
end
