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
  # @api private
  def self.root
    environment.root
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
