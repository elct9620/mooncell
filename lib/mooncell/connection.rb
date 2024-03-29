# frozen_string_literal: true

module Mooncell
  # The connection wrapper
  #
  # @since 0.1.0
  class Connection
    # @since 0.1.0
    # @api private
    attr_reader :app

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

    # Write data
    #
    # @param data [] the data to write
    #
    # @since 0.1.0
    def write(data)
      io.write(data)
    end

    private

    attr_reader :io

    # @since 0.1.0
    # @api private
    def prepare
      app.pool.add(self)
    end
  end
end
