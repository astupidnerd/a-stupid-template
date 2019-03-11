##
# Wazza template generator.
#
# @author Steven Jeffries

# The current version of this template script.
VERSION = "0.1.0"

#
# ──────────────────────────────────────────────────────────────────── I ──────────
#   :::::: H E L P E R   M E T H O D S : :  :   :    :     :        :          :
# ──────────────────────────────────────────────────────────────────────────────
#

# Convenience method to get the root of this template.
def template_root
  File.expand_path(__dir__)
end

# This adds the root of this template as a source path so that it can easily
# copy over its files into the destination project.
def source_paths
  [template_root]
end

# Cancels the generation and deletes the destination directory.
def abort!
  FileUtils.rm_rf(destination_root)
  exit(1)
end

# Convenience method for joining paths relative to the template root.
def join(*paths)
  File.expand_path(File.join(__dir__, *paths))
end

# Convenience method for evaluating the setup scripts.
def setup(*items)
  items.flatten.uniq.each do |item|
    item += ".rb" unless item.match(/\.rb$/)
    eval(File.read(join("setup", item)))
  end
end

# Just like ask, but with a default value.
def demand(question, default = nil)
  response = ask("#{question} \e[0;32m[#{default}]\e[0m")
  response == "" ? default : response
end

#
# ────────────────────────────────────────────────────────── II ──────────
#   :::::: R U N   S E T U P : :  :   :    :     :        :          :
# ────────────────────────────────────────────────────────────────────
#

# Run each of the scripts in the setup directory.
setup("config", "files", "gems", "devise", "post_install")
