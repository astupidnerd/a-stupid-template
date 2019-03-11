require "tmpdir"

##
# Wazza template generator.
#
# @author Steven Jeffries

# The current version of this template script.
VERSION = "0.1.0"

#
# ──────────────────────────────────────────────────────────  ──────────
#   :::::: B O O T S T R A P : :  :   :    :     :        :          :
# ────────────────────────────────────────────────────────────────────
#

# If this is being run from the bitbucket url, then none of the files this template
# uses will be present, so we need to clone the repo somewhere:

if File.exists?(File.join(__dir__, "rails", "Vagrantfile.erb"))
  # We are safely inside the repo (probably).
  def template_root
    File.expand_path(__dir__)
  end
else
  puts "Downloading required files..."
  @tmp_dir = Dir.mktmpdir("rails-wazza-template")

  run("git clone https://stevenjeffries@bitbucket.org/stupidnerds/rails-wazza-template.git #{@tmp_dir}")

  def template_root
    @tmp_dir
  end
end

#
# ──────────────────────────────────────────────────────────────────── I ──────────
#   :::::: H E L P E R   M E T H O D S : :  :   :    :     :        :          :
# ──────────────────────────────────────────────────────────────────────────────
#

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
  File.expand_path(File.join(template_root, *paths))
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

FileUtils.rm_rf(@tmp_dir) if @tmp_dir && File.directory?(@tmp_dir)
