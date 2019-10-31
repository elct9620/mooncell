# frozen_string_literal: true

module Mooncell
  # Respond Generator
  #
  # @since 0.1.0
  #
  # @example
  #
  #   class Move
  #     include Mooncell::Respond
  #   end
  module Respond
    # @since 0.1.0
    # @api private
    def self.included(base)
      base.class_eval do
        include InstanceMethods
      end
    end

    # @since 0.1.0
    # @api private
    module InstanceMethods
      # @since 0.1.0
      # @api private
      def initialize(command)
        @command = command
      end
    end
  end
end
