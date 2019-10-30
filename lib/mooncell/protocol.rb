# frozen_string_literal: true

require 'concurrent'

module Mooncell
  # Mooncell Network Protocol
  #
  # @since 0.1.0
  # @api private
  module Protocol
    require 'mooncell/protocol/registry'

    class << self
      # @since 0.1.0
      # @api private
      def included(base)
        super
        Registry.register(base)
      end

      # @since 0.1.0
      # @api private
      def get(name)
        Registry.lookup(name)
      end
    end
  end
end
