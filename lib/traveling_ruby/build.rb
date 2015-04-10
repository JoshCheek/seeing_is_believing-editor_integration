module TravelingRuby
  # A noun, as in "the build" (should I just rename it? "build" is too verby)
  class Build
    attr_accessor :platforms, :world, :ui

    def initialize(platforms:, world:, ui:)
      self.platforms = platforms
      self.world     = world
      self.ui        = ui
    end

    def build
      platforms.each do |platform|
        # Download TravelingRuby
        world.memoize filename: platform.compressed_ruby do |file|
          world.get url:  platform.traveling_ruby_url, file: file
        end

        # Extract TravelingRuby
        # mkdir hello-1.0.0-linux-x86/lib/ruby
        # tar -xzf packaging/traveling-ruby-20141215-2.1.5-linux-x86.tar.gz -C
        # hello-1.0.0-linux-x86/lib/ruby
        # -C: continue from previous work
        world.extract source:      platform.compressed_ruby,
                      destination: platform.ruby_dir

        # Install the dependencies
        # here, we'll need Bundler
        # FIXME!

        # Create the wrapper
        # cp packaging/wrapper.sh hello-1.0.0-linux-x86/hello
        # chmod +x packaging/wrapper.sh
        world.memoize filename: platform.wrapper_path, permissions: 0755 do |file|
          file.write platform.wrapper_body
        end

        world.compress source: platform.package_dir,
                       dest:   platform.dest_path
        # # From a user's perspective
        # The user downloads hello-1.0.0-linux-x86.tar.gz.
        # The user extracts this file.
        # /path-to/hello-1.0.0-linux-x86/hello
      end
    end
  end
end
