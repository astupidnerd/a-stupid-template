#
# ────────────────────────────────────────────────────────────── I ──────────
#   :::::: R E M O V E   G E M S : :  :   :    :     :        :          :
# ────────────────────────────────────────────────────────────────────────
#

gsub_file "Gemfile", /^(gem\s+["']sqlite3["'].*)$/, "# \\1"
gsub_file "Gemfile", /^(gem\s+["']coffee-rails["'].*)$/, "# \\1"
gsub_file "Gemfile", /^(gem\s+["']turbo-links["'].*)$/, "# \\1"

#
# ──────────────────────────────────────────────────────── II ──────────
#   :::::: A D D   G E M S : :  :   :    :     :        :          :
# ──────────────────────────────────────────────────────────────────
#

gem_group :development, :test do
  gem "pry"
  gem "pry-rails"
  gem "rspec-rails"
  gem "factory_bot_rails"
end

gem_group :test do
  gem "faker"
end

gem_group :development do
  gem "annotate", git: "https://github.com/ctran/annotate_models.git"
  gem "binding_of_caller"
  gem "better_errors"
  gem "capistrano", require: false
  gem "capistrano-bundler", require: false
  gem "capistrano-logtail", require: false
  gem "capistrano-rails", require: false
  gem "capistrano-rbenv", require: false
  gem "capistrano3-nginx", require: false
  gem "capistrano3-puma", require: false
end

gem "devise"
gem "pg"
gem "fast_jsonapi"
gem "slim-rails"
gem "webpacker"

#
# ──────────────────────────────────────────────────────────────────────── III ──────────
#   :::::: B U N D L E   A N D   S E T U P : :  :   :    :     :        :          :
# ──────────────────────────────────────────────────────────────────────────────────
#

run "bundle"

generate "rspec:install"

#
# ─── WEBPACKER ──────────────────────────────────────────────────────────────────
#

rails_command "webpacker:install"
rails_command "webpacker:install:vue"

#
# ─── SLIM ───────────────────────────────────────────────────────────────────────
#

run "gem install html2slim"

#
# ─── POSTGRESQL ─────────────────────────────────────────────────────────────────
#

app_db_name = app_name.gsub(/[^a-zA-Z]+/, "_").gsub(/^_+|_+$/, "")

gsub_file "config/database.yml", /adapter: sqlite3/, "adapter: postgresql"
gsub_file "config/database.yml", /database: db\/(\w+).sqlite3/, "database: #{app_db_name}_\\1"
