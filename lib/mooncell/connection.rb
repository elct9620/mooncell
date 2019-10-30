# frozen_string_literal: true

module Mooncell
  # The connection wrapper
  #
  # @since 0.1.0
  class Connection
    # Create a connection
    #
    # @param io [#write] the writable I/O
    #
    # @since 0.1.0
    def initialize(io, app)
      @io = io
      @app = app

      prepare
    end

    private

    attr_reader :io, :app

    # @since 0.1.0
    # @api private
    def prepare
      app.pool.add(self)
    end
  end
end
