# frozen_string_literal: true

require 'mooncell/cli'
require 'mooncell/cli/commands/registry'
require 'mooncell/cli/commands/base'

module Mooncell
  class CLI
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

      # @return [Boolean] Is application initialized
      #
      # @since 0.1.0
      # @api private
      def self.app_initialized?
        Gem.loaded_specs.key?('mooncell') &&
          Mooncell.root.join('config', 'boot.rb').exist?
      end

      require 'mooncell/cli/commands/version'
      require 'mooncell/cli/commands/console'
      require 'mooncell/cli/commands/server'
    end
  end
end
