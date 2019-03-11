#
# ──────────────────────────────────────────────────── I ──────────
#   :::::: C O N F I G : :  :   :    :     :        :          :
# ──────────────────────────────────────────────────────────────
#

# This script asks the user for input on various configurations for the template generator.

#
# ────────────────────────────────────────────────── II ──────────
#   :::::: S E T U P : :  :   :    :     :        :          :
# ────────────────────────────────────────────────────────────
#

# etc is used to find the login user to come up with the default value for the repo URL.
require "etc"

puts "

# Configuration #

"

# Sets up all of the variables to be used for all of the erb templates and other setup scripts.
self.singleton_class.class_eval do
  attr_reader :ruby_version, :deploy_user, :app_name, :repo_url, :local_server, :staging_server, :production_server, :local_db_name
end

#
# ──────────────────────────────────────────────────────────── III ──────────
#   :::::: U S E R   I N P U T : :  :   :    :     :        :          :
# ──────────────────────────────────────────────────────────────────────
#

# The ruby version to install from the provision script.
# Defaults to the ruby version running this script.
@ruby_version = demand("Ruby version used for deploys", RUBY_VERSION).strip

# The name of the user to use for deploying. This is used
# by the provision script. Defaults to `deploy`.
@deploy_user = demand("Deploy user", "deploy").strip

# The name of the application. This is used by the provision
# script to create directories and it is also used to name
# the databases. It defaults to the name passed to `rails new`.
@app_name = demand("Application name", File.basename(destination_root)).strip

# The repo url for your project. If this isn't set here, then
# it will need to be updated in the project's local git repository
# as well as the `config/deploy.rb` file.
@repo_url = demand("Repo URL", "https://github.com/#{Etc.getlogin}/#{app_name}.git").strip

# The local ip address to use for the vagrant server. This is
# used for the `local` capistrano deployment environment and
# the vagrant machine.
@local_server = demand("Vagrant local server", "192.168.47.88").strip

# The url of the staging server. This is used by capistrano in the
# `config/deploy/staging.rb` file.
@staging_server = demand("Staging server", "staging.example.com").strip

# The url of the production server. This is used by capistrano in the
# `config/deploy/production.rb` file.
@production_server = demand("Production server", "example.com").strip

# This is used by the Vagrantfile to set the database name for the local
# environment.
@local_db_name = "#{app_name.gsub(/[^a-zA-Z0-9]+/, "_").gsub(/^_+|_+$/, "")}_local"
