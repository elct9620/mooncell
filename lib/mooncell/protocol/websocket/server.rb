# frozen_string_literal: true

require 'faye/websocket'
require 'json'

module Mooncell
  module Protocol
    class WebSocket
      # WebSocket Server implement
      #
      # @since 0.1.0
      # @api private
      class Server
        # @since 0.1.0
        # @api private
        attr_reader :app

        # Create WebSocket Server
        #
        # @since 0.1.0
        # @api private
        def initialize(app, env)
          @ws = Faye::WebSocket.new(env)
          @app = app

          @ws.on :open, method(:open)
          @ws.on :message, method(:message)
          @ws.on :close, method(:close)
        end

        # Rack Response
        #
        # @since 0.1.0
        # @api private
        def rack_response
          @ws.rack_response
        end

        # On WebSocket open
        #
        # @since 0.1.0
        # @api private
        def open(_event)
          @conn = Mooncell::Connection.new(self, app)
        end

        # On WebSocket receive data
        #
        # @since 0.1.0
        # @api private
        def message(event)
          # TODO: Support customize serializer
          params = JSON.parse(event.data)
          app.router.call(@conn, params)
        rescue JSON::ParserError
          # TODO: Handling error
          write(error: -1)
        end

        # On WebSocket close
        #
        # @since 0.1.0
        # @api private
        def close(_event)
          app.pool.delete(@conn)
        end

        # Writable API
        #
        # @since 0.1.0
        # @api private
        def write(data)
          @ws.send(data.to_json)
        end
      end
    end
  end
end
