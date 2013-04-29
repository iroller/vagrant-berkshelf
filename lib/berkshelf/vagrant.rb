begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant Berkshelf plugin must be run within Vagrant."
end

require 'berkshelf'
require 'berkshelf/vagrant/version'
require 'berkshelf/vagrant/errors'
require 'tmpdir'
require 'fileutils'

module Berkshelf
  # @author Jamie Winsor <reset@riotgames.com>
  module Vagrant
    autoload :Action, 'berkshelf/vagrant/action'
    autoload :Config, 'berkshelf/vagrant/config'
    autoload :Env, 'berkshelf/vagrant/env'
    autoload :EnvHelpers, 'berkshelf/vagrant/env_helpers'

    class << self
      # The path to where shelfs are created on the host machine to be mounted in
      # Vagrant guests
      #
      # @return [String]
      def shelf_path
        File.join(Berkshelf.berkshelf_path, 'vagrant')
      end

      # Generate a new shelf to be mounted in a Vagrant guest
      #
      # @return [String]
      #   path to the generated shelf
      def mkshelf(machine_name)

        unless File.exist?(shelf_path)
          FileUtils.mkdir_p(shelf_path)
        end

        Dir.mktmpdir(['berkshelf-', "-#{machine_name}"], shelf_path)
      end
    end
  end
end

require 'berkshelf/vagrant/plugin'
