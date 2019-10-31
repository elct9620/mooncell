# frozen_string_literal: true

require 'mooncell/application_configuration'
require 'mooncell/router'

module Mooncell
  # Mooncell Application
  #
  # @since 0.1.0
  # @api private
  class Application
    # @since 0.1.0
    # @api private
    def self.inherited(base)
      super
      base.extend ClassMethods
    end

    # @since 0.1.0
    # @api private
    module ClassMethods
      # @since 0.1.0
      # @api private
      def self.extended(base)
        super
        base.class_eval do
          @_lock = Mutex.new

          class << self
            # @since 0.1.0
            # @api private
            attr_reader :configuration
          end
        end
      end

      # Application name
      #
      # @return [String] the application name
      #
      # @since 0.1.0
      # @api private
      def app_name
        @app_name ||=
          name.split('::').first.downcase
      end

      # Configure the application
      #
      # TODO: Support specify by environment
      #
      # @param block [Proc] the configuration block
      #
      # @since 0.1.0
      # @api private
      def configure(&block)
        @_lock.synchronize do
          @configuration = ApplicationConfiguration.new(&block)
        end
      end
    end

    # @since 0.1.0
    # @api private
    attr_reader :pool, :router

    # Create application instance
    #
    # @since 0.1.0
    # @api private
    def initialize
      @pool = ConnectionPool.new
      @router = Router.new(self)

      # TODO: Add support to reload router
      setup_router
    end

    # Run application
    #
    # @since 0.1.0
    # @api private
    def call(*)
      protocol = Protocol.get(configuration.protocol)
      protocol.new(self).start
    end

    # Return the application configuration
    #
    # @return [Mooncell::ApplicationConfiguration] application configuration
    #
    # @see Application.configuration
    #
    # @since 0.1.0
    # @api private
    def configuration
      self.class.configuration
    end

    private

    # @since 0.1.0
    # @api private
    def setup_router
      path =
        Mooncell
        .environment
        .apps_path
        .join(self.class.app_name, 'config', 'routes.rb')
      code = File.open(path, 'rb:bom|utf-8', &:read)
      @router.load(code)
    end
  end
end
