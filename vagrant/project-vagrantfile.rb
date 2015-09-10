class Skeletor
	def Skeletor.configure(config, settings)
	# Configure The Box
	config.vm.box = "yourimage.box"
	config.vm.box_url = "s3urlofimage"
	config.vm.hostname = settings["projectname"]

	# Configure A Private Network IP
	config.vm.network :private_network, ip: settings["ip"]

	# Forward SSH key from local
	config.ssh.forward_agent = true

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

	# Need something custom in this project? Set it here, test it, and we can bake it into the image after a while
	# If you need multiple commands, put them together in a script or repeat this block for each line
	config.vm.provision "shell" do |s|
      s.path = "./vagrant/scripts/provision/project-extraprovision.sh"
	end

	end
end