module Initializer
  def self.run
    require_config
    require_lib
    require_initializers
    require_models
  end

  def self.require_config
    if ENV['NEW_RELIC_LICENSE_KEY']
      require 'newrelic_rpm'
    end
    require_relative "../config/config"
  end

  def self.require_lib
    require! %w(
      lib/endpoints/base
      lib/endpoints/**/*
      lib/mediators/base
      lib/mediators/**/*
      lib/routes
      lib/serializers/base
      lib/serializers/**/*
      lib/helpers
    )
  end

  def self.require_models
    require! %w(
      lib/models/**/*
    )
  end

  def self.require_initializers
    Pliny::Utils.require_glob("#{Config.root}/config/initializers/*.rb")
  end

  def self.require!(globs)
    globs = [globs] unless globs.is_a?(Array)
    globs.each do |f|
      Pliny::Utils.require_glob("#{Config.root}/#{f}.rb")
    end
  end
end

Initializer.run
