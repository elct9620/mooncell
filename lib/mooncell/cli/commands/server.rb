# frozen_string_literal: true

module Mooncell
  class CLI
    module Commands
      # @since 0.1.0
      # @api private
      class Server < Base
        requires 'all'

        def call(*)
          # TODO: Boot servers
        end

        register 'server', Commands::Server, aliases: %w[s], app_only: true
      end
    end
  end
end
