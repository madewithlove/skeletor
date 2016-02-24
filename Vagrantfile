require 'json'
require 'yaml'

VAGRANTFILE_API_VERSION ||= "2"
confDir = $confDir ||= File.expand_path("vendor/laravel/homestead", File.dirname(__FILE__))

require File.expand_path(confDir + '/scripts/homestead.rb')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    Homestead.configure(config, YAML::load(File.read("Homestead.yaml")))

    # Custom provision
    # config.vm.provision "shell", path: "./resources/provision/elasticsearch.sh"
    # config.vm.provision "shell", path: "./resources/provision/node.sh"
    # config.vm.provision "shell", path: "./resources/provision/neo4j.sh"
end
