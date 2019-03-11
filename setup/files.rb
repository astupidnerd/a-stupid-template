#
# ──────────────────────────────────────────────────────────── I ──────────
#   :::::: C O P Y   F I L E S : :  :   :    :     :        :          :
# ──────────────────────────────────────────────────────────────────────
#

path_sub_regex = Regexp.new("^#{template_root}/?rails/")
erb_sub_regex = /\.erb$/

Dir[File.join(template_root, "rails/**/*")].reject { |f| File.directory?(f) }.each do |path|
  relative_path = path.sub(path_sub_regex, "")
  copy_path = relative_path.sub(erb_sub_regex, "")

  if copy_path == relative_path
    copy_file(path, copy_path)
  else
    template(path, copy_path)
  end

  if copy_path.match(/\.sh$/)
    FileUtils.chmod("+x", File.join(destination_root, copy_path))
  end
end

production_environment_file = File.join(destination_root, "config", "environments", "production.rb")
copy_file(production_environment_file, "config/environments/staging.rb")
copy_file(production_environment_file, "config/environments/local.rb")

#
# ──────────────────────────────────────────────────────────────── II ──────────
#   :::::: D E L E T E   F I L E S : :  :   :    :     :        :          :
# ──────────────────────────────────────────────────────────────────────────
#

remove_dir "test"
