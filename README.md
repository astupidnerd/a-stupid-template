# Rails Wazza Template

This is a template that I use for starting new rails projects. It includes some gems and configuration right
out of the box to make it easy to spin up a new app without having to think too hard about all of that boring
initial setup.


This application template starts off your rails project with:


**Application**

- rspec instead of test_unit
- factory bot
- pry
- better errors
- Netflix fast_jsonapi
- slim instead of erb
- devise, already configured with a user model
- adds remote url for git repo
- test, development, local, staging, and production environments
- defaults to postgresql instead of sqlite3
- removes coffee script and turbo links
- installed with webpacker and vue
- home controller with an index page containing a vue app
- a Procfile set up to run the rails server and webpack dev server

**Deploying**

- capistrano 3 with nginx and puma
- provision scripts for provisioning a deploy server
- vagrant for testing deployments on your local machine
- local, staging, and production environments


## TL;DR

```bash
$ rails new <name> -m https://bitbucket.org/stevenjeffries/rails-wazza-template/raw/master/template.rb
```

## Installation

### 1. Create a git repository.

The wazza template will automatically inject your git repo URL into the capistrano deploy script and add the remote origin to the new rails repo, so it is much easier to have that repo URL ahead of time.

### 2. Create a rails app with this template.

Use this template when creating a new rails app by passing the URL to the template file:

```bash
$ rails new <name> -m https://bitbucket.org/stevenjeffries/rails-wazza-template/raw/master/template.rb
```

You can also clone this repo locally and edit it before using it. The `-m` accepts a path as well:

```bash
$ rails new <name> -m path/to/template.rb
```

### 3. Enter your information.

The template generator will ask you to enter some information when generating the new rails app.

> Ruby version used for deploys

This is the ruby version you want to use for your remote servers when deploying code to it.

It will default to your current ruby version (the ruby version running the script).

If you decide to change this after the fact, you will need to change it in: both provision scripts in `bin/provision` (section I), all deploy environment files in `config/deploy`, and your Vagrantfile (arguments passed to the provision script).

> Deploy user

This is the user the provision script creates for deploys, and the user capistrano tries to log in as.

It defaults to `deploy`.

If you decide to change this later, you will need to update it in: both provision scripts in `bin/provision` (section I), the capistrano deploy file `config/deploy.rb`, all deploy environment files in `config/deploy`, and your Vagrantfile (arguments passed to the provision script).

> Application name

This is the name of your application (or rather, the name of its directory). It is used by the provision script to create the directories used for deployments, as well as
being used for the database names for each environment.

It defaults to the directory being create (the `name` passed to `rails new`).

If you decide to change this later, you will need to do a lot of work.

> Repo URL

This is your project's git repo URL. It is used by capistrano to know which repo to clone when doing deploys.

It defaults to `https://github.com/<logged in user>/<application name>.git`.

If you decide to change this later, you will need to update it in: your local git repo, and the capistrano deploy script `config/deploy.rb`.

> Vagrant local server

This is a local IP address used by vagrant when creating the local deploy environment.

It defaults to `192.168.47.88`.

If you decide to change this later, you will need to update it in: your local deploy environment (`config/deploy/local.rb`), your Vagrantfile (the `private_network` ip).

> Staging server

This is the URL to your staging server. It is used by capistrano during deploys.

It defaults to `staging.example.com`.

If you decide to change this later, you will need to update it in your staging deploy environment file (`config/deploy/staging.rb`).

> Production server

This is the URL to your production server. It is used by capistrano during deploys.

It defaults to `example.com`.

If you decide to change this later, you will need to update it in your production deploy environment file (`config/deploy/production.rb`).


## Local Deploy

This template includes a very basic provision script for setting up a new server to deploy your rails app to.

I've also included a Vagrantfile that will run that provision script so you can test your deploys on your local machine.

This isn't needed by everyone, but it is especially helpful to have for any apps that will be deployed several times.

If you've kept the basic setup, then you should already be set to deploy locally:

### TL;DR

```bash
$ git checkout development # -b if this is a new branch
$ git add .
$ git commit
$ git push origin development
$ vagrant up
$ cap local deploy
```


### 1. Commit and push to the development branch

The default branch used for local deploys is development. If you are using a different branch (like `dev` for example), just remember to change it in the `config/deploy/local.rb` file.

```bash
$ git checkout development # -b if this is a new branch
$ git add .
$ git commit
$ git push origin development
```

### 2. Provision your vm

With the default settings, just:

```bash
$ vagrant up
```

The first time you run this, it will take a while to install all of the dependencies, etc. The provision script only has to run once.

You can always `vagrant halt` to turn the vm off when you're done. Running `vagrant destroy` will delete the vm and all of its files.

### 3. Deploy to it

Once the vagrant machine is live:

```bash
$ cap local deploy
```

## Learn More

I use rbenv for managing ruby versions on my local machine, as well as deployment servers:

- [rbenv](https://github.com/rbenv/rbenv)

I use vagrant and virtualbox for managing my virtual machines:

- [vagrant](https://github.com/hashicorp/vagrant)
- [virtualbox](https://www.virtualbox.org/)

Overmind is really useful for running multiple servers/programs at once:

- [overmind](https://github.com/DarthSim/overmind)

Here are links to all of the other gems and libraries I've included in this template:

- [rspec](https://github.com/rspec/rspec) and [rspec-rails](https://github.com/rspec/rspec-rails)
- [factory_bot](https://github.com/thoughtbot/factory_bot) and [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
- [pry](https://github.com/pry/pry) and [pry-rails](https://github.com/rweng/pry-rails)
- [better_errors](https://github.com/BetterErrors/better_errors) and [binding_of_caller](https://github.com/banister/binding_of_caller)
- [fast_jsonapi](https://github.com/Netflix/fast_jsonapi)
- [slim](https://github.com/slim-template/slim) and [slim-rails](https://github.com/slim-template/slim-rails)
- [devise](https://github.com/plataformatec/devise)
- [webpacker](https://github.com/rails/webpacker) and [vue](https://github.com/vuejs/vue)
- [capistrano](https://github.com/capistrano/capistrano), [capistrano-rails](https://github.com/capistrano/rails), [capistrano-bundler](https://github.com/capistrano/bundler), 
[capistrano-logtail](https://gitlab.com/ydkn/capistrano-logtail), [capistrano-rbenv](https://github.com/capistrano/rbenv), [capistrano3-nginx](https://github.com/treenewbee/capistrano3-nginx), [capistrano3-puma](https://github.com/seuros/capistrano-puma)




