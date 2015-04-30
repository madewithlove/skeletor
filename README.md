# Skeletor

## Creating a new project

Replace `{project}` with the project name

```bash
$ composer create-project madewithlove/skeletor {project} "4.2.*@dev" -s dev
```

### Updating the skeleton

```bash
$ git remote add upstream git@github.com:laravel/laravel.git
$ git pull upstream master
```

## Setting up the vagrant

Edit the config file at vagrant/skeletor-config.yml.  
After that just do 'vagrant up'to get started.
