class Homestead
  def Homestead.configure(config, settings)
    # Configure The Box
    config.vm.box = "laravel/homestead"
    config.vm.box_url = "https://vagrantcloud.com/laravel/homestead/version/9/provider/virtualbox.box"
    config.vm.hostname = "homestead"

    # Configure A Private Network IP
    # Change ip. Make xxx unique across all our projects
    config.vm.network :private_network, ip: settings["ip"] ||= "192.168.xxx.yyy"

    # Configure A Few VirtualBox Settings
    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", settings["memory"] ||= "2048"]
      vb.customize ["modifyvm", :id, "--cpus", settings["cpus"] ||= "1"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end

    # Configure Port Forwarding To The Box
    # Change the host ports to a variation. Fill IP's xxx value in to guarantuee uniqueness across projects.
    # This way, if multiple boxes are up at the same time, there won't be collisions.
    config.vm.network "forwarded_port", guest: 80, host: 8xxx
    config.vm.network "forwarded_port", guest: 22, host: 56xxx, id: "ssh"
    config.vm.network "forwarded_port", guest: 3306, host: 33xxx
    config.vm.network "forwarded_port", guest: 5432, host: 54xxx

    # Enable SSH agent forwarding
    config.ssh.forward_agent = true

    # Copy The Bash Aliases (& do some other custom MWL stuff that we added)
    config.vm.provision "shell" do |s|
      s.inline = "cp /vagrant/vagrant/aliases /home/vagrant/.bash_aliases"
      s.inline = "sudo composer self-update"
      s.inline = "cd /vagrant && composer install"
      s.inline = "mysql --user=homestead --password=secret -e \"CREATE DATABASE IF NOT EXISTS homestead_test\""
    end

    # Register All Of The Configured Shared Folders
    settings["folders"].each do |folder|
      config.vm.synced_folder folder["map"], folder["to"], type: folder["type"] ||= nil
    end

    # Install All The Configured Nginx Sites
    settings["sites"].each do |site|
      config.vm.provision "shell" do |s|
          s.inline = "bash /vagrant/vagrant/scripts/serve.sh $1 $2"
          s.args = [site["map"], site["to"]]
      end
    end

    # Configure All Of The Server Environment Variables
    if settings.has_key?("variables")
      settings["variables"].each do |var|
        config.vm.provision "shell" do |s|
            s.inline = "echo \"\nenv[$1] = '$2'\" >> /etc/php5/fpm/php-fpm.conf && service php5-fpm restart"
            s.args = [var["key"], var["value"]]
        end
      end
    end
  end
end
