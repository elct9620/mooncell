# frozen_string_literal: true

require 'singleton'
require 'forwardable'

module Mooncell
  class CLI
    module Commands
      # Command Registry
      #
      # @since 0.1.0
      # @api private
      class Registry
        include Singleton

        class << self
          extend Forwardable

          delegate %w[add get] => 'instance'
        end

        # @since 0.1.0
        # @api private
        def initialize
          @commands = {}
          @aliases = {}
        end

        # @since 0.1.0
        # @api private
        def add(name, command = nil, aliases: [], &block)
          return if @commands[name]

          @commands[name] = command&.new || block
          aliases.each do |token|
            next if @aliases[token]

            @aliases[token] = @commands[name]
          end
        end

        # @since 0.1.0
        # @api private
        def get(arguments)
          arguments.each do |token|
            tmp = @commands[token] || @aliases[token]
            return tmp if tmp
          end
          nil
        end
      end
    end
  end
end
