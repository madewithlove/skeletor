VAGRANTFILE_API_VERSION = "2"
 
 require 'yaml'
 require './vagrant/skeletor-vagrantfile.rb'
 
 Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 	Skeletor.configure(config, YAML::load(File.read('./vagrant/skeletor-config.yaml')))
 end