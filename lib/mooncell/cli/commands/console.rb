# frozen_string_literal: true

require 'pry'

module Mooncell
  class CLI
    module Commands
      # @since 0.1.0
      # @api private
      class Console < Base
        requires 'all'

        # Provide code reload for console
        #
        # @since 0.1.0
        # @api private
        module CodeReloading
          # @since 0.1.0
          # @api private
          def reload!
            puts 'Reloading...'
            Mooncell::Loader.reload!
          end
        end

        def call(*)
          TOPLEVEL_BINDING.eval('self').__send__(:include, CodeReloading)
          Pry.start
        end

        register 'console', Commands::Console, aliases: %w[c], app_only: true
      end
    end
  end
end
