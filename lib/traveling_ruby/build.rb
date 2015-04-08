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
end
