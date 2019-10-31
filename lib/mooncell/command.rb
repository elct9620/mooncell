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
      # @since 0.1.0
      # @api private
      def initialize(conn)
        @conn = conn
      end

      # @since 0.1.0
      # @api private
      def respond
        name = self.class.name.sub(/Commands/, 'Responds')
        Kernel.const_get(name).new(self)
      end
    end
  end
end
