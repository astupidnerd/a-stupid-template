run "erb2slim '#{destination_root}/app/views' '#{destination_root}/app/views' -d"

# Adds the vue example to home#index
prepend_to_file("app/views/home/index.html.slim", "= javascript_pack_tag 'hello_vue'\n= stylesheet_pack_tag 'hello_vue'\n\n")

append_to_file(".gitignore", "\n.vagrant\n")

run "git remote add origin #{repo_url}"

append_to_file "config/database.yml", "
local:
  <<: *default
  database: blarg_local
"

run "bundle exec annotate"
