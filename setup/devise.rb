#
# ──────────────────────────────────────────────────────────────────── I ──────────
#   :::::: D E V I S E   I N S T A L L : :  :   :    :     :        :          :
# ──────────────────────────────────────────────────────────────────────────────
#

generate "devise:install"
generate "devise user"

devise_migration_file = Dir[File.join(destination_root, "db/migrate/*devise_create_users.rb")].first

gsub_file devise_migration_file, /^(\s+)# /, "\\1"

devise_initializer_file = File.join(destination_root, "config/initializers/devise.rb")
FileUtils.mv(devise_initializer_file, File.join(destination_root, "config/initializers/000_devise.rb"))

generate "controller home index"
route 'root to: "home#index"'

environment_urls = {
  local: local_server,
  staging: staging_server,
  production: production_server,
}

environment_urls.each do |environment, url|
  if url =~ URI::regexp
    uri = URI.parse(url)
    host = uri.host
    port = uri.port
  else
    host = url
    port = environment == :local ? 80 : 443
  end

  environment "config.action_mailer.default_url_options = {host: '#{host}', port: #{port}}", env: environment
end

generate "devise:views"
