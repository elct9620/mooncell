# frozen_string_literal: true

require 'mooncell/cli'
require 'mooncell/cli/commands/registry'
require 'mooncell/cli/commands/base'

module Mooncell
  # CLI Commands
  #
  # @since 0.1.0
  # @api private
  module Commands
    # @since 0.1.0
    # @api private
    def self.get(arguments)
      Registry.get(arguments)
    end

    require 'mooncell/cli/commands/version'
  end
end
