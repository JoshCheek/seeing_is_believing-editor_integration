module TravelingRuby
  # as in "the build"
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
        # curl -L -O --fail http://d6r77u77i8pq3.cloudfront.net/releases/traveling-ruby-20141215-2.1.5-linux-x86.tar.gz
        #
        # -L:      If the server reports that the requested page has moved to a different
        #          location (indicated with a Location: header and  a  3XX  response
        #          code),  this  option  will  make curl redo the request on the new place.
        #
        # -O:      Write  output  to a local file named like the remote file we get. (Only the
        #          file part of the remote file is used, the path is cut off.)
        #
        # --fail:  Fail  silently  (no output at all) on server errors.
        world.memoize filename: platform.compressed_ruby do |file|
          world.get url:  platform.traveling_ruby_url, file: file
        end

        # Extract TravelingRuby
        # mkdir hello-1.0.0-linux-x86/lib/ruby
        # tar -xzf packaging/traveling-ruby-20141215-2.1.5-linux-x86.tar.gz -C hello-1.0.0-linux-x86/lib/ruby
        # -C: continue from previous work
        world.decompress source: compressed_ruby, dest: platform.ruby_dir

        # Install the dependencies
        # here, we'll need Bundler
        # FIXME!

        # # Quick sanity testing
        # cd hello-1.0.0-osx
        # ./lib/ruby/bin/ruby lib/app/hello.rb # => hello world
        # cd ..
        require "pry"
        binding.pry

        # Create the wrapper
        # cp packaging/wrapper.sh hello-1.0.0-linux-x86/hello
        # chmod +x packaging/wrapper.sh
        world.memoize filename: platform.wrapper_path do |file|
          file.write platform.wrapper_body
        end
        world.chmod file: platform.wrapper_path, permissions: 0755

        world.compress source: platform.package_dir, dest: platform.dest_path
        # # From a user's perspective
        # The user downloads hello-1.0.0-linux-x86.tar.gz.
        # The user extracts this file.
        # /path-to/hello-1.0.0-linux-x86/hello
      end
    end
  end
end
