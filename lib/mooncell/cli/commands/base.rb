# frozen_string_literal: true

require 'mooncell'

module Mooncell
  class CLI
    module Commands
      # Base class for commands
      #
      # @since 0.1.0
      # @api private
      class Base
        class << self
          # @since 0.1.0
          # @api private
          def register(
            name,
            command = nil,
            aliases: [],
            app_only: false,
            &block
          )
            Registry.add(
              name,
              command,
              aliases: aliases,
              app_only: app_only,
              &block
            )
          end
        end
      end
    end
  end
end
