# Skeletor

## Creating a new project

Replace `{project}` with the project name

```bash
$ composer create-project madewithlove/skeletor {project} -s dev
```

## Configuring Vagrant

Skeletor is delivered to you with a modified Homestead configuration.  

We can't have exactly the same settings for each new project. IP addresses, for example, will differ each time.  So here are the steps you can take to get Vagrant running for your project.

### In vagrant/Homestead.yaml
1. Decide on an IP. Have it be in the format 192.168.xxx.yyy. Make 'xxx' unique across the company to prevent collision.
2. Change the sitename to {your project name}.dev

### In vagrant/scripts/homestead.rb
1. Change the IP here too, to the same as in Homestead.yaml
2. Change the host parts of the port forwarding. Use the same 'xxx' value as your IP for the last three digits of those ports. This way there won't be port collisions if you have multiple Vagrants running.


To finish up, put a reference to your box in your hostsfile so your browser will know where to surf to.  

```
sudo nano /etc/hosts

Add a line like:
192.168.xxx.yyy your-project-name.dev
```


Then just go:  

```
vagrant up
```

And wait for the box to be complete.  
This might take a while if this is the first time you pull in the Homestead box we use, because it will need to download that box from Vagrant Cloud. If you have it already, it should be fast.


### Updating the skeleton

```bash
$ git remote add upstream git@github.com:laravel/laravel.git
$ git pull upstream master
```

