module EmailFetch::Hunt
  class Search
    extend GluttonRatelimit

    def initialize
      @start = Time.now
      @utils = Fetch::Utils.new
      @log = @utils.log
    end

    def search(query)
      raise NotImplementedError.new('This method should be overridden by a subclass.')
    end
  end
end
