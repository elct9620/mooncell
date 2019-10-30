# frozen_string_literal: true

require 'faye/websocket'

module Mooncell
  module Protocol
    class WebSocket
      # @since 0.1.0
      # @api private
      BAD_RESPONSE = [
        400,
        {},
        []
      ].freeze

      # @since 0.1.0
      # @api private
      POOL = Mooncell::ConnectionPool.new

      # WebSocket Server implement
      #
      # @since 0.1.0
      # @api private
      class Server < Faye::WebSocket
        def self.call(env)
          return BAD_RESPONSE unless Faye::WebSocket.websocket?(env)

          new(env).rack_response
        end

        def initialize(env)
          super

          on :open, &:open
          on :message, &:message
          on :close, &:close
        end

        def open
          @conn = Mooncell::Connection.new(self, POOL)
        end

        def message
          # TODO
        end

        def close
          POOL.delete(@conn)
        end
      end
    end
  end
end
