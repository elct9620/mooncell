# frozen_string_literal: true

require 'singleton'
require 'forwardable'

module Mooncell
  module Protocol
    # @since 0.1.0
    # @api private
    class Registry
      class << self
        extend Forwardable

        delegate %w[register lookup] => 'instance'
      end

      include Singleton

      def initialize
        @protocols = Concurrent::Map.new
      end

      def register(klass)
        name = klass.name.split('::').last.downcase
        @protocols[name] = klass
      end

      def lookup(name)
        @protocols[name]
      end
    end
  end
end
