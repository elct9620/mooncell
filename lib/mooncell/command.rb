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
        extend ClassMethods
        include InstanceMethods

        attr_reader :conn
      end
    end

    # @since 0.1.0
    # @api private
    module ClassMethods
      # Expose instance variable
      #
      # @param [Array<Symbol>] the variable name to expose
      #
      # @since 0.1.0
      # @api private
      def expose(*names)
        class_eval do
          names.each do |name|
            attr_reader name unless attr_reader?(name)
          end

          exposures.push(*names)
        end
      end

      # @since 0.1.0
      # @api private
      def exposures
        @exposures ||= []
      end

      private

      # @since 0.1.0
      # @api private
      def attr_reader?(name)
        (instance_methods | private_instance_methods).include?(name)
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
