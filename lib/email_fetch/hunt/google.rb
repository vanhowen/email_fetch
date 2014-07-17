module EmailFetch::Hunt
  class Google < Search

    ROOT_URL  = 'http://google.com'
    PREFERENCES_URL = 'http://www.google.com/preferences'

    def initialize
      super
      @log.info('Creating a new Google search driver.')

      @log.info('Setting preferences for Google searching.')
      # Retrieves the preferences page and configures the number of search results to 20.
      preferences_page = @utils.get_page(PREFERENCES_URL)
      settings_form = preferences_page.form_with(name: 'langform')
      settings_form.num = 20
      @utils.submit_form(settings_form)
      @log.info('Done configuring preferences. Ready for searching!')

      @search_omitions = ['-pubget', '-mendeley', '-facebook', '-twitter', '-researchgate',
                          '-expeditioninspiration', '-quartzy', '-linkedin', '-filetype:pdf',
                          '-filetype:xls', '-filetype:xlsx', '-filetype:ppt', '-filetype:pptx',
                          '-filetype:doc', '-filetype:docx', '-filetype:rtf'].join(' ')
    end

    def search(query)
      @log.info("Searching Google for '#{query}'")

      q = [query, @search_omitions].join(' ')

      # Run the search.
      page = @utils.get_page(ROOT_URL)
      search_form = page.form_with(name: 'f')
      search_form.q = q
      results_page = @utils.submit_form(search_form)

      search_results = results_page.search('h3.r a')
      result_urls = get_urls(search_results)
      result_urls << results_page.uri.to_s
      return result_urls
    end
    # Limits the frequency of how often the search method is called. In this case, it's limited to
    # 6 calls for every 60 seconds of clock time.
    rate_limit :search, 6, 60

    def inspect
      self.class.to_s
    end

    private

    # Takes an array of Google search results and returns an array of URLs for the given results.
    def get_urls(search_results)
      # A Google search_result looks like:
      # <a href="/url?q=https://www.scienceexchange.com/">Science Exchange<b>...</b></a>
      # To get the actual page URL, use the 'href' and get the query param 'q' term.
      urls = []
      search_results.each do |result|
        url = result['href']
        query = URI.parse(url).query
        result_url = CGI.parse(query)['q'].first
        result_url = url if result_url.nil?
        urls << result_url
      end
      return urls
    end
  end
end
