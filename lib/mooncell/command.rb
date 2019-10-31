# frozen_string_literal: true

module Mooncell
  # A Command Handler
  #
  # @since 0.1.0
  #
  # @example
  #   class Move
  #     include Mooncell::Command
  #
  #     def call(params)
  #     end
  #   end
  module Command
    # @since 0.1.0
    # @api private
    def self.included(base)
      base.class_eval do
        include InstanceMethods

        attr_reader :conn
      end
    end

    # @since 0.1.0
    # @api private
    module InstanceMethods
      def initialize(conn)
        @conn = conn
      end
    end
  end
end
