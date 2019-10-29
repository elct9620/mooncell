# frozen_string_literal: true

module Mooncell
  module Commands
    # Command to response version
    #
    # @since 0.1.0
    # @api private
    class Version < Base
      # @since 0.1.0
      # @api private
      def call(*)
        puts "v#{Mooncell::VERSION}"
      end

      register 'version', Commands::Version, aliases: %w[v -v --version]
    end
  end
end
