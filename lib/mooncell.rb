# frozen_string_literal: true

require 'mooncell/version'

# A online game server framework for Ruby
#
# @since 0.1.0
module Mooncell
  require 'mooncell/command'
  require 'mooncell/respond'
  require 'mooncell/entity'
  require 'mooncell/protocol'

  require 'mooncell/environment'
  require 'mooncell/configuration'

  # @since 0.1.0
  # @api private
  @_mutex = Mutex.new

  # Return current environment
  #
  # @return [String] the current environment
  #
  # @since 0.3.1
  #
  # @see Mooncell::Environment#environment
  #
  # @example
  #   Mooncell.env => "development"
  def self.env
    environment.environment
  end

  # Return application root
  #
  # @since 0.1.0
  def self.root
    environment.root
  end

  # Configure the Mooncell
  #
  # @param block [Proc] the configuration block
  #
  # @since 0.1.0
  #
  # @example
  #   # config/environment.rb
  #
  #   # ...
  #
  #   Mooncell.configure do
  #     protocol :websocket
  #   end
  def self.configure(&block)
    @_mutex.synchronize do
      @_configuration = Mooncell::Configuration.new(&block)
    end
  end

  # Mooncell Configuration
  #
  # @return [Mooncell::Configuration] the configuration
  #
  # @see Mooncell.configure
  #
  # @since 0.1.0
  # @api private
  def self.configuration
    @_mutex.synchronize do
      raise 'Mooncell not configured' unless defined?(@_configuration)

      @_configuration
    end
  end

  # Current environment
  #
  # @return [Mooncell::Environment] environment
  #
  # @since 0.1.0
  # @api private
  def self.environment
    @environment ||= Environment.new
  end
end
