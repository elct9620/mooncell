# frozen_string_literal: true

require 'faye/websocket'

module Mooncell
  module Protocol
    class WebSocket
      # WebSocket Server implement
      #
      # @since 0.1.0
      # @api private
      class Server < Faye::WebSocket
        # @since 0.1.0
        # @api private
        attr_reader :app

        # Create WebSocket Server
        #
        # @since 0.1.0
        # @api private
        def initialize(app, env)
          super(env)

          @app = app

          on :open, &:open
          on :message, &:message
          on :close, &:close
        end

        # On WebSocket open
        #
        # @since 0.1.0
        # @api private
        def open
          @conn = Mooncell::Connection.new(self, app)
        end

        # On WebSocket receive data
        #
        # @since 0.1.0
        # @api private
        def message
          # TODO
        end

        # On WebSocket close
        #
        # @since 0.1.0
        # @api private
        def close
          app.pool.delete(@conn)
        end
      end
    end
  end
end
