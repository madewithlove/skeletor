class Skeletor
	def Skeletor.configure(config, settings)
	# Configure The Box
	config.vm.box = "ubuntu/trusty64"
	config.vm.hostname = settings["projectname"]

	# Configure A Private Network IP
	config.vm.network :private_network, ip: settings["ip"]

	# Configure A Few VirtualBox Settings
	config.vm.provider "virtualbox" do |vb|
	  vb.customize ["modifyvm", :id, "--memory", "2048"]
	  vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	  vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
	end

	# Configure Port Forwarding To The Box
	config.vm.network "forwarded_port", guest: 80, host: settings["ports"]["web"]
	config.vm.network "forwarded_port", guest: 22, host: settings["ports"]["ssh"], id: "ssh"
	config.vm.network "forwarded_port", guest: 3306, host: settings["ports"]["mysql"]

	# Run The Provisioning Scripts 
	config.vm.provision "shell" do |s|
	  # Installs the stuff we always need (PHP, nginx, etc)
	  s.path = "./vagrant/scripts/provision/base.sh"

	  # Install the custom things we selected in our config file
	  s.path = "./vagrant/scripts/provision/custom.sh"
	end

	# Sync the vm's /vagrant folder to our project root
	config.vm.synced_folder '.', '/vagrant/'

	# Make an nginx vhost with <projectname>.dev as url and /vagrant/public as docroot
	config.vm.provision "shell" do |s|
	  s.inline = "bash /vagrant/vagrant/scripts/provision/nginx-serve.sh $1 $2"
	  s.args = [ settings["projectname" ] + '.dev' , '/vagrant/public' ]
	end

	# Configure All Of The Server Environment Variables
    if settings.has_key?("variables")
      settings["variables"].each do |var|
        config.vm.provision "shell" do |s|
            s.inline = "echo \"\nenv[$1] = '$2'\" >> /etc/php5/fpm/php-fpm.conf"
            s.args = [var["key"], var["value"]]
        end
      end

      config.vm.provision "shell" do |s|
          s.inline = "service php5-fpm restart"
      end
    end

    # Update Composer On Every Provision
    config.vm.provision "shell" do |s|
      s.inline = "/usr/local/bin/composer self-update"
    end

	end
end