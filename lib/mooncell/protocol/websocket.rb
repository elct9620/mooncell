# frozen_string_literal: true

require 'rack'

module Mooncell
  module Protocol
    # WebSocket Protocol
    class WebSocket
      require 'mooncell/protocol/websocket/server'

      include Mooncell::Protocol

      # @since 0.1.0
      # @api private
      BAD_RESPONSE = [
        400,
        {},
        []
      ].freeze

      # Create protocol instance
      #
      # TODO: Generalize protocol behaviors
      #
      # @since 0.1.0
      # @api private
      def initialize(app)
        @app = app
      end

      # Start Server
      #
      # @since 0.1.0
      # @api private
      def start
        Rack::Handler.default.run(self, options)
      end

      # Implement Rack interface
      #
      # @param env [Hash] the rack environment
      #
      # @since 0.1.0
      # @api private
      def call(env)
        return BAD_RESPONSE unless Faye::WebSocket.websocket?(env)

        WebSocket::Server.new(app, env).rack_response
      end

      # Return options
      #
      # @return [Hash] the server options
      #
      # @since 0.1.0
      # @api private
      def options
        {
          Port: app.configuration.port
        }
      end

      private

      # @since 0.1.0
      # @api private
      attr_reader :app
    end
  end
end
