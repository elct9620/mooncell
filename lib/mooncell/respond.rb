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
        extend ClassMethods
        include InstanceMethods
      end
    end

    # @since 0.1.0
    # @api private
    module ClassMethods
      # @since 0.1.0
      # @api private
      @broadcast = false

      # Set broadcast
      #
      # @param value [TureClass,FalseClass] should broadcast to all players
      #
      # @since 0.1.0
      # @api private
      def broadcast(value = true)
        @broadcast = value == true
      end

      # Get broadcast
      #
      # @return [TureClass,FalseClass] is a broadcast respond
      #
      # @since 0.1.0
      # @api private
      def broadcast?
        @broadcast == true
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

      # @since 0.1.0
      # @api private
      def send
        response = call
        if self.class.broadcast?
          command.conn.app.pool.each do |conn|
            conn.write(response)
          end
        else
          command.conn.write(response)
        end
      end

      private

      # @since 0.1.0
      # @api private
      attr_reader :command
    end
  end
end
