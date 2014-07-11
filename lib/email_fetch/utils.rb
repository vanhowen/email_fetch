module EmailFetch
  class Utils

    def initialize
      @agent = Mechanize.new
      @agent.read_timeout = 20
      @agent.ssl_version = 'SSLv3'
      @agent.verify_mode = OpenSSL::SSL::VERIFY_NONE

      @log = Log4r::Logger.new('SearchDrivers::Search')
      format = Log4r::PatternFormatter.new(pattern: "[%d] %p %l %m")
      outputter = Log4r::Outputter.stdout
      outputter.formatter = format
      log.outputters << outputter
      @log.level = Log4r::INFO
    end
    attr_reader :log

    # Retrieves the webpage associated with the given URL. It tries up to 3 times. If it is unable
    # to load the page, nil is returned.
    def get_page(url)
      @log.info("Loading page: #{url}")
      try_three_times do
        page = @agent.get(url)
        page.encoding = 'utf-8' if page.is_a?(Mechanize::Page)
        return page
      end
    end

    # Submits the given form. Returns the page that loads after the form submit.
    def submit_form(form)
      @agent.submit(form)
    end

    def analyze_email(email_addresses, compare_string)
      email = FuzzyMatch.new(email_addresses).find(compare_string)
      @log.info "Found address #{email} for '#{compare_string}'" unless email.nil?
      return email
    end

    def inspect
      self.class.to_s
    end
    private

    # Provides a wrapper so that methods can be tried multiple times.
    def try_three_times
      tries = 0
      begin
        yield
      rescue Exception => e
        tries += 1
        @log.error("Error: #{e.message}")
        if tries < 3
          @log.error("Trying again")
          retry
        end
        @log.error("Tried 3 times without success, aborting.")
        return nil
      end
    end
  end
end
