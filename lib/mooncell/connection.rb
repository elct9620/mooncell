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
    def initialize(io, pool)
      @io = io
      @pool = pool

      prepare
    end

    private

    attr_reader :io, :pool

    # @since 0.1.0
    # @api private
    def prepare
      pool.add(self)
    end
  end
end
