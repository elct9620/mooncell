# frozen_string_literal: true

module Mooncell
  module Commands
    # Base class for commands
    #
    # @since 0.1.0
    # @api private
    class Base
      class << self
        # @since 0.1.0
        # @api private
        def register(name, command = nil, aliases: [], &block)
          Registry.add(name, command, aliases: aliases, &block)
        end
      end
    end
  end
end
