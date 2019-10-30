# frozen_string_literal: true

require 'concurrent'
require 'forwardable'

module Mooncell
  # The connection pool
  #
  # @since 0.1.0
  # @api private
  class ConnectionPool
    extend Forwardable
    include Enumerable

    delegate %w[add delete] => 'connections'

    # @since 0.1.0
    # @api private
    attr_reader :connections

    # Create a new connection pool
    #
    # @since 0.1.0
    # @api private
    def initialize
      @connections = Concurrent::Set.new
    end

    # Iterate connections
    #
    # @param block [Proc] the iterate block
    #
    # @since 0.1.0
    # @api private
    def each(&block)
      @connections.each(&block)
    end
  end
end
