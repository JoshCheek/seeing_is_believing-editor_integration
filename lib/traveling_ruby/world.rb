require 'zlib'
require 'open3'
require 'net/http'

module TravelingRuby
  class World
    def memoize(filename:, &setter)
      return if File.exist? filename
      dir! File.dirname(filename)
      File.open filename, 'w', &setter
    end

    def dir!(path)
      return if Dir.exist? path
      dir! File.dirname(path)
      Dir.mkdir path
    end

    def get(url:, file:)
      # from https://github.com/ruby/ruby/blob/2afed6eceff2951b949db7ded8167a75b431bad6/lib/net/http.rb#L236
      uri = URI(url)
      Net::HTTP.start uri.host, uri.port do |http|
        http.request Net::HTTP::Get.new(uri) do |response|
          response.read_body &file.method(:write)
        end
      end
    end


    def extract(source:, destination:)
      dir! destination

      # There's a tar lib that was edited in December
      # https://github.com/halostatue/minitar (I think I met that dude at Rubyconf!)
      #
      # But the gem hasn't been updated since 2008
      # https://rubygems.org/gems/archive-tar-minitar
      #
      # So, going to shell out for now, just b/c it's easier than figuring that out.
      read, write = IO.pipe
      tar_pid = spawn "tar", '-x', '-f', '-', '-C', destination, in: read
      Zlib::GzipReader.open source do |gz|
        write.write gz.read
        write.close
      end
      Process.wait tar_pid
    end

  end
end
