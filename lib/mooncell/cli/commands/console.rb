# frozen_string_literal: true

require 'pry'

module Mooncell
  class CLI
    module Commands
      # @since 0.1.0
      # @api private
      class Console < Base
        requires 'all'

        def call(*)
          Pry.start
        end

        register 'console', Commands::Console, aliases: %w[c], app_only: true
      end
    end
  end
end
