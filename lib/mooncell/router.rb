# frozen_string_literal: true

require 'concurrent'

module Mooncell
  # Command Dispatcher
  #
  # @since 0.1.0
  # @api private
  class Router
    # Create rotuer instance
    #
    # @since 0.1.0
    # @api private
    def initialize(app)
      @app = app
      @routes = Concurrent::Hash.new
    end

    # Load routes
    #
    # @since 0.1.0
    # @api private
    def load(code)
      instance_eval(code)
    end

    # Add command
    #
    # @param name [String] the command name
    # @param command [Mooncell::Command] the command
    #
    # @since 0.1.0
    # @api private
    def command(name, command)
      @routes[name] = command
    end

    # Execute to command
    #
    # @param params [Hash] the request parameters
    #
    # @since 0.1.0
    # @api private
    def call(connection, params)
      command_name = params.delete('command')
      command_class = @routes[command_name]
      return if command_class.nil?

      command = Kernel.const_get(command_class).new(connection)
      command.call(params)
      response = command.responder.call
      connection.write(response)
    end
  end
end
