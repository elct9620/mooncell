# frozen_string_literal: true

require 'dotenv'

module Mooncell
  # Environment container
  #
  # @since 0.1.0
  # @api private
  class Env
    # Create a new instance
    #
    # @param env [#[],#[]=] a Hash like object. Default is ENV
    #
    # @return [Mooncell::Env]
    #
    # @since 0.1.0
    # @api private
    def initialize(env: ENV)
      @env = env
    end

    # Return a value if found
    #
    # @param key [String] The key
    #
    # @return [String,NilClass] the value
    #
    # @since 0.1.0
    # @api private
    def [](key)
      @env[key]
    end

    # Set a value
    #
    # @param key [String] the key
    # @param value [String] the value
    #
    # @since 0.1.0
    # @api private
    def []=(key, value)
      @env[key] = value
    end

    # Load environment from dotenv
    #
    # @param path [String, Pathname] the path to the dotenv file
    #
    # @return void
    #
    # @since 0.1.0
    # @api private
    def load!(path)
      return unless defined?(Dotenv::Parser)

      contents = ::File.open(path, 'rb:bom|utf-8', &:read)
      parsed = Dotenv::Parser.call(contents)

      parsed.each do |k, v|
        next if @env.key?(k)

        @env[k] = v
      end
    end
  end
end
