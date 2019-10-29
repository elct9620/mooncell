# frozen_string_literal: true

module Mooncell
  # Command Line Interface
  class CLI
    # @since 0.1.0
    # @api private
    def call
      command = Commands.get(ARGV)
      # TODO: Display help message
      return if command.nil?

      command.call(ARGV)
    end
  end
end
