# frozen_string_literal: true

require 'rack'

module Mooncell
  module Protocol
    # WebSocket Protocol
    class WebSocket
      require 'mooncell/protocol/websocket/server'

      include Mooncell::Protocol

      def boot(options = {})
        Rack::Handler.default.run(WebSocket::Server, options)
      end
    end
  end
end
