require 'zlib'
require 'open3'
require 'net/http'

module TravelingRuby
  class World
    def memoize(filename:, permissions: nil, &setter)
      return if File.exist? filename
      dir! File.dirname(filename)
      File.open filename, 'w', &setter
    ensure
      return unless permissions
      return if 0777&permissions == 0777&File.stat(filename).mode
      File.chmod permissions, filename
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

    def chmod(filename:, permissions:)
      File.chmod(permissions, filename)
    end

    def compress(source:, dest:)
      return if File.exist? dest
      source_dir      = File.dirname  source
      source_filename = File.basename source
      dest_dir        = File.dirname  dest
      dest_filename   = File.basename dest

      dir! dest_dir
      if dest_filename.end_with? '.tar.gz'
        tar_pid = Dir.chdir source_dir do
          spawn 'tar', '-c', '-z', '-f', dest, source_filename
        end
        Process.wait tar_pid
      else
        raise "FORMAT NOT SUPPORTED YET!: #{dest_filename.inspect}}"
      end
    end

  end
end
