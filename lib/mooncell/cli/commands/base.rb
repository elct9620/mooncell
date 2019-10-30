# frozen_string_literal: true

require 'mooncell'
require 'concurrent'

module Mooncell
  class CLI
    module Commands
      # Base class for commands
      #
      # @since 0.1.0
      # @api private
      class Base
        class << self
          # @since 0.1.0
          # @api private
          # rubocop:disable Metrics/LineLength
          def register(name, command = nil, aliases: [], app_only: false, &block)
            Registry.add(name, command, aliases: aliases, app_only: app_only, &block)
          end
          # rubocop:enable Metrics/LineLength

          # @since 0.1.0
          # @api private
          def inherited(base)
            super
            base.class_eval do
              @_requirements = Concurrent::Array.new
              extend ClassMethods
              prepend InstanceMethods
            end
          end
        end

        # @sincle 0.1.0
        # @api private
        module ClassMethods
          # @since 0.1.0
          # @api private
          def requires(*names)
            @_requirements.concat(names)
          end

          # @since 0.1.0
          # @api private
          def requirements
            @_requirements
          end
        end

        # @since 0.1.0
        # @api private
        module InstanceMethods
          def call(*)
            if self.class.requirements.any?
              Mooncell.environment.require_project_environment
              # TODO: Load requirements
            end
            super
          end
        end
      end
    end
  end
end
