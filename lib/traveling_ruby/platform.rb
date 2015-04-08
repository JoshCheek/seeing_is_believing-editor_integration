module TravelingRuby
  class Platform
    # some metaprogramming might be nice here...
    attr_accessor :app_name,
                  :app_version,
                  :platform_name,
                  :executable_name,
                  :executable,
                  :binary_host,
                  :traveling_ruby_version,
                  :compression_format

    def initialize(app_name:,
                   app_version:,
                   platform_name:,
                   executable_name:,
                   executable:,
                   binary_host:,
                   traveling_ruby_version:,
                   compression_format:)
      self.app_name               = app_name.to_s
      self.app_version            = app_version.to_s
      self.platform_name          = platform_name.to_s
      self.executable_name        = executable_name
      self.executable             = executable
      self.binary_host            = binary_host
      self.traveling_ruby_version = traveling_ruby_version
      self.compression_format     = compression_format
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
end
