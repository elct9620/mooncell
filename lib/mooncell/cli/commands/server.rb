# frozen_string_literal: true

module Mooncell
  class CLI
    module Commands
      # @since 0.1.0
      # @api private
      class Server < Base
        requires 'all'

        # @since 0.1.0
        # @api private
        def call(*)
          # TODO: Add support for multiple application
          _, app = Mooncell.configuration.apps.first
          return if app.nil?

          app.call
        end

        register 'server', Commands::Server, aliases: %w[s], app_only: true
      end
    end
  end
end
