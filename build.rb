#!/usr/bin/env ruby

def not_implemented
  raise "Implement me!: #{caller[0]}"
end


class Platform
  # some metaprogramming might be nice here...
  attr_accessor :app_name,
                :app_version,
                :platform_name,
                :executable_name,
                :executable_format,
                :binary_host,
                :ruby_build_date,
                :ruby_version,
                :compression_format

  def initialize(app_name:,
                 app_version:,
                 platform_name:,
                 executable_name:,
                 executable_format:,
                 binary_host:,
                 ruby_build_date:,
                 ruby_version:,
                 compression_format:)
    self.app_name           = app_name.to_s
    self.app_version        = app_version.to_s
    self.platform_name      = platform_name.to_s
    self.executable_name    = executable_name
    self.executable_format  = executable_format
    self.binary_host        = binary_host
    self.ruby_build_date    = ruby_build_date
    self.ruby_version       = ruby_version
    self.compression_format = ruby_version
  end

  def package_dir
    File.join app_name.to_s, app_version.to_s, platform_name.to_s
  end

  def app_dir
    File.join package_dir, 'lib', 'app'
  end

  def ruby_binary_url
    File.join binary_host, "traveling-ruby-#{ruby_build_date}-#{ruby_version}-#{platform_name}#{compression_format}"
  end
end


class Build # the noun version
  attr_accessor :name, :version, :platform, :fs, :ui

  def initialize(name:, version:, platforms:, fs:, ui:)
    self.fs        = fs
    self.ui        = ui
    self.name      = name
    self.version   = version
    self.platforms = platforms
  end

  def build
    # download SiB from Rubygems, unless it is already downloaded
    # https://rubygems.org/downloads/seeing_is_believing-3.0.0.beta.5.gem

    # for each platform
    #   make its package_dir                 mkdir -p hello-1.0.0-osx/lib/app
    #   copy SiB into it                     cp -r sib_dir hello-1.0.0-osx/lib/app/
    #   download the associated binary       curl -L -O --fail http://d6r77u77i8pq3.cloudfront.net/releases/traveling-ruby-20141215-2.1.5-osx.tar.gz
    #   extract it into the packsage         mkdir hello-1.0.0-osx/lib/ruby &&
    #                                        tar -xzf packaging/traveling-ruby-20141215-2.1.5-osx.tar.gz -C hello-1.0.0-osx/lib/ruby
    #   write the wrapper script if it DNE   write it to: hello-1.0.0-osx/hello
    #   Make it executable                   chmod +x hello-1.0.0-osx/hello                          <-- is this still true for Windows?
    #   compress the script                  tar -czf hello-1.0.0-linux-x86.tar.gz hello-1.0.0-osx   <-- Windows?
  end
end


class FileSystem
end

class UserInterface
  attr_accessor :outstream, :errstream
  private :outstream
  private :errstream
  def initialize(outstream:, errstream:)
    self.outstream, self.errstream = outstream, errstream
  end
end

common_platform_config = {
  app_name:           'seeing_is_believing',
  app_version:        '3.0.0.beta.5',
  executable_name:    'seeing_is_believing',
  executable_format:  :unix_shell,
  binary_host:        'http://d6r77u77i8pq3.cloudfront.net/releases',
  ruby_build_date:    '20150210',
  ruby_version:       '2.2.0',
  compression_format: '.tar.gz',
}

build = Build.new(
  fs:        FileSystem.new,
  ui:        UserInterface.new($stdout, $stderr),
  name:      'seeing_is_believing',
  version:   '3.0.0.beta.5',
  platforms: [
    Platform.new(common_platform_config.merge platform_name: 'linux-x86'),
    Platform.new(common_platform_config.merge platform_name: 'linux-x86_64'),
    Platform.new(common_platform_config.merge platform_name: 'linux-osx'),
  ],
)

build.build
