module TravelingRuby
  class Platform
    # some metaprogramming might be nice here...
    attr_accessor :app_name,
                  :app_version,
                  :gemfile,
                  :platform_name,
                  :wrapper_name,
                  :wrapper_body,
                  :binary_host,
                  :traveling_ruby_version,
                  :compression_format,
                  :working_dir

    def initialize(app_name:,
                   app_version:,
                   gemfile:,
                   platform_name:,
                   wrapper_name:,
                   wrapper_body:,
                   binary_host:,
                   traveling_ruby_version:,
                   compression_format:,
                   working_dir:)
      self.app_name               = app_name
      self.app_version            = app_version
      self.gemfile                = gemfile
      self.platform_name          = platform_name
      self.wrapper_name           = wrapper_name
      self.wrapper_body           = wrapper_body
      self.binary_host            = binary_host
      self.traveling_ruby_version = traveling_ruby_version
      self.compression_format     = compression_format
      self.working_dir            = working_dir
    end

    def package_dir
      File.join app_name.to_s, app_version.to_s, platform_name.to_s
    end

    def app_dir
      File.join package_dir, 'lib', 'app'
    end

    def traveling_ruby_filename
      "traveling-ruby-#{traveling_ruby_version}-#{platform_name}.tar.gz"
    end

    def traveling_ruby_url
      File.join binary_host, traveling_ruby_filename
    end

    def wrapper_path
      File.join package_dir, wrapper_path
    end

    def compressed_ruby
      in_working_dir traveling_ruby_filename
    end

    def in_working_dir(path)
      File.join working_dir, path
    end
  end
end
