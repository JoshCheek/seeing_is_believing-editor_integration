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
                  :build_dir,
                  :cache_dir

    def initialize(app_name:,
                   app_version:,
                   gemfile:,
                   platform_name:,
                   wrapper_name:,
                   wrapper_body:,
                   binary_host:,
                   traveling_ruby_version:,
                   compression_format:,
                   build_dir:,
                   cache_dir:)
      self.app_name               = app_name
      self.app_version            = app_version
      self.gemfile                = gemfile
      self.platform_name          = platform_name
      self.wrapper_name           = wrapper_name
      self.wrapper_body           = wrapper_body
      self.binary_host            = binary_host
      self.traveling_ruby_version = traveling_ruby_version
      self.compression_format     = compression_format
      self.build_dir              = build_dir
      self.cache_dir              = cache_dir
    end

    def package_dir
      File.join build_dir, package_name
    end

    def app_dir
      File.join package_dir, 'lib', 'app'
    end

    def ruby_dir
      File.join package_dir, 'lib', 'ruby'
    end

    def package_name
      "#{app_name}-#{app_version}-#{platform_name}"
    end

    def traveling_ruby_filename
      "traveling-ruby-#{traveling_ruby_version}-#{platform_name}.tar.gz"
    end

    def traveling_ruby_url
      File.join binary_host, traveling_ruby_filename
    end

    def wrapper_path
      File.join package_dir, wrapper_name
    end

    def compressed_ruby
      File.join cache_dir, traveling_ruby_filename
    end

    def dest_path
      File.join build_dir, "#{package_name}#{compression_format}"
    end
  end
end
