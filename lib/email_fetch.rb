# External requires
require 'cgi'
require 'fuzzy_match'
require 'glutton_ratelimit'
require 'log4r'
require 'mechanize'
require 'uri'

# Fetch requires
dir = File.expand_path(File.dirname(__FILE__))
require File.join(dir, 'email_fetch', 'version')
require File.join(dir, 'email_fetch', 'utils')

module EmailFetch

end
