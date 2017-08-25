# Skeletor

![Skeletor](https://pbs.twimg.com/profile_images/146235348/skeletor.jpg)

## Creating a new project

Replace `{project}` with the project name

```bash
$ composer create-project madewithlove/skeletor {project} -s dev
```

### Updating the skeleton

```bash
$ git remote add upstream git@github.com:laravel/laravel.git
$ git pull upstream master
```

## Setting up Docker

### Installation
Make sure you have installed Docker (>=1.13) and Docker Compose (>=1.9) 
- Run `brew cask install docker`

### Instantiation 
- Run `./dev up -d.` This will pull the images and run the containers (db and app) as detached (not holding your terminal). After this, you can check the containers running using docker ps or `./dev ps`. The difference here between `./dev ps` and `docker ps` is that docker ps will show ALL containers running, while `./dev ps` forwards the call to `docker-compose ps` which only shows containers running for this application (services defined in the docker-compose.yml)
- That's it!

If you are running into permission issues when executing `./dev` commands, try: `chmod +x ./dev`
If you can't run `./dev` script directly, try `sh ./dev` instead
If you have port conflicts, "export" that port to an unused one i.e.: `export APP_PORT=9000` or `export DB_PORT=31`
