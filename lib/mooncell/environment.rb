# frozen_string_literal: true

require 'mooncell/env'

module Mooncell
  # Mooncell environment
  #
  # @since 0.1.0
  # @api private
  class Environment
    # Global lock
    #
    # @since 0.1.0
    # @api private
    LOCK = Mutex.new

    # Standard Mooncell ENV Key
    #
    # @since 0.1.0
    # @api private
    MOONCELL_ENV = 'MOONCELL_ENV'

    # Default Mooncell environment
    #
    # @since 0.1.0
    # @api private
    DEFAULT_ENV = 'development'

    # Mooncell test environment
    #
    # @since 0.1.0
    # @api private
    TEST_ENV = 'test'

    # Mooncell production environment
    #
    # @since 0.1.0
    # @api private
    PRODUCTION_ENV = 'production'

    # @since 0.1.0
    # @api private
    DOTENV_LOCAL_FILE = '.env.local'

    # Default `.env` files will be loaded
    #
    # @since 0.1.0
    # @api private
    DOTENV_FILES = [
      '.env.%<environment>s.local',
      DOTENV_LOCAL_FILE,
      '.env.%<environment>s',
      '.env'
    ].freeze

    # Initialize a Mooncell Environment
    #
    # @api private
    def initialize(options = {})
      opts = options.to_h.dup
      @env = Mooncell::Env.new(env: opts.delete(:env) || ENV)
      LOCK.synchronize { load_env_vars! }
    end

    # Application's root
    #
    # @return [Pathname] application's root
    #
    # @since 0.1.0
    # @api private
    def root
      @root ||= Bundler.root
    rescue Bundler::GemfileNotFound
      @root = Pathname.new(Dir.pwd)
    end

    # The current environment
    #
    # @return [String] the current environment
    #
    # @since 0.1.0
    # @api private
    #
    # @see Mooncell::Environment::DEFAULT_ENF
    def environment
      @environment ||= env[MOONCELL_ENV] || DEFAULT_ENV
    end

    # Project environment configuration path
    #
    # @return [Pathname] path to application
    #
    # @since 0.1.0
    # @api private
    def config
      root.join('config', 'environment.rb')
    end

    # @api private
    alias project_config config

    # Load project environment configuration
    #
    # @since 0.1.0
    # @api private
    def require_project_environment
      require project_config.to_s
    end

    private

    attr_reader :env

    # @since 0.1.0
    # @api private
    def load_env_vars!
      DOTENV_FILES.each do |filename_format|
        file = format(filename_format, environment: environment)
        next unless dotenv_applicable?(file)

        path = root.join(file)
        env.load!(path) if path.exist?
      end
    end

    # @since 0.1.0
    # @api private
    def dotenv_applicable?(file)
      return false if file == DOTENV_LOCAL_FILE && environment == TEST_ENV

      true
    end
  end
end
