module TravelingRuby
  class UserInterface
    attr_accessor :outstream, :errstream
    private :outstream
    private :errstream
    def initialize(outstream:, errstream:)
      self.outstream, self.errstream = outstream, errstream
    end
  end
end
