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
          @root = Node.new
        end

        # @since 0.1.0
        # @api private
        def add(name, command = nil, aliases: [], app_only: false, &block)
          @root.add(name, command, aliases: aliases, app_only: app_only, &block)
        end

        # @since 0.1.0
        # @api private
        def get(arguments)
          node = @root

          arguments.each do |token|
            current = node.lookup(token)
            return node if current.nil? && node.leaf?

            node = current
          end

          node
        end

        # @since 0.1.0
        # @api private
        class Node
          attr_reader :name, :command

          # @since 0.1.0
          # @api private
          def initialize(name = nil, command = nil, app_only: false)
            @name = name
            @command = command
            @children = {}
            @app_only = app_only
          end

          # @return [Boolean] is only for application
          #
          # @since 0.1.0
          # @api private
          def app_only?
            @app_only == true
          end

          # @return [Boolean] is the end of command
          # @since 0.1.0
          # @api private
          def leaf?
            @children.empty?
          end

          # @since 0.1.0
          # @api private
          def add(name, command = nil, aliases: [], app_only: false, &block)
            node = Node.new(name, command || block, app_only: app_only)
            @children[name] = node
            aliases.each { |token| @children[token] = node }
          end

          # @since 0.1.0
          # @api private
          def lookup(name)
            @children[name]
          end

          # @since 0.1.0
          # @api private
          def call(*args)
            return if app_only? && !Commands.app_initialized?
            return if command.nil?
            return command.call(*args) if command.is_a?(Proc)

            command.new.call(*args)
          end
        end
      end
    end
  end
end
