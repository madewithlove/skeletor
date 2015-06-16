VAGRANTFILE_API_VERSION = "2"
 
 require 'yaml'
 require './vagrant/base-vagrantfile.rb'
 
 Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 	Skeletor.configure(config, YAML::load(File.read('./vagrant/config.yaml')))
 end