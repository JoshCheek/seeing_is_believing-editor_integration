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

  end
end
