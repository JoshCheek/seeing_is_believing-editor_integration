require 'rubygems'
require 'rubygems/package'

# how to use open .tar.gz directly
# https://github.com/rubygems/rubygems/blob/83e592ebd86cd93fcd7bc79a9629198dabe6a247/lib/rubygems/package.rb#L439

the_gem = Gem::Package.new('ast-2.0.0.gem')
the_gem.contents                            # get the files in the gem
the_gem.extract_files 'tmp'                 # extract the gem into a directory
the_gem.spec                                # get the spec out of the gem
the_gem.verify                              # check the gem is OK (contains valid gem specification, contains a not corrupt contents archive)

__END__
# Constructs an Installer instance that will install the gem located at
# +gem+.  +options+ is a Hash with the following keys:
#
# :bin_dir:: Where to put a bin wrapper if needed.
# :development:: Whether or not development dependencies should be installed.
# :env_shebang:: Use /usr/bin/env in bin wrappers.
# :force:: Overrides all version checks and security policy checks, except
#          for a signed-gems-only policy.
# :format_executable:: Format the executable the same as the Ruby executable.
#                      If your Ruby is ruby18, foo_exec will be installed as
#                      foo_exec18.
# :ignore_dependencies:: Don't raise if a dependency is missing.
# :install_dir:: The directory to install the gem into.
# :security_policy:: Use the specified security policy.  See Gem::Security
# :user_install:: Indicate that the gem should be unpacked into the users
#                 personal gem directory.
# :only_install_dir:: Only validate dependencies against what is in the
#                     install_dir
# :wrappers:: Install wrappers if true, symlinks if false.
# :build_args:: An Array of arguments to pass to the extension builder
#               process. If not set, then Gem::Command.build_args is used
installer = Gem::Installer.new 'ast-2.0.0.gem', {
  bin_dir:             'tmp/thebins',
  development:         false,
  ignore_dependencies: false,
  install_dir:         'tmp/thelibs', # gem_home
  only_install_dir:    true,          # for dependency validation
  wrappers:            false,         # uses symlinks... do these work on Windows?
}

# Installs the gem and returns a loaded Gem::Specification for the installed gem.
# The gem will be installed with the following structure:
#   @gem_home/
#     cache/<gem-version>.gem #=> a cached copy of the installed gem
#     gems/<gem-version>/... #=> extracted files
#     specifications/<gem-version>.gemspec #=> the Gem::Specification
installer.install

