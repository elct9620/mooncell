# frozen_string_literal: true

require 'zeitwerk'
require 'singleton'
require 'forwardable'

module Mooncell
  # Code Loader
  #
  # @since 0.1.0
  # @api private
  class Loader
    class << self
      extend Forwardable

      delegate [
        'setup',
        'reload!'
      ] => 'instance'
    end

    include Singleton

    # @since 0.1.0
    # @api private
    def initialize
      @loader = Zeitwerk::Loader.new
    end

    # Setup Loader
    #
    # @since 0.1.0
    # @api private
    def setup
      prepare
      # TODO: Code Reloading
      loader.enable_reloading if Mooncell.code_reloading?
      loader.setup
      # TODO: Eager Load
    end

    # Reload Code
    #
    # @since 0.1.0
    # @api private
    def reload!
      loader.reload
    end

    private

    # @since 0.1.0
    # @api private
    attr_reader :loader

    # @since 0.1.0
    # @api private
    def prepare
      loader.push_dir(Mooncell.environment.apps_path)
    end
  end
end
