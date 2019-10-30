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
        def self.call(env)
          new(env)
        end
      end
    end
  end
end
