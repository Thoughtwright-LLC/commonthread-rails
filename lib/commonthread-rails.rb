require 'commonthread/date_formats'

require 'cgi' unless defined?(CGI)
require 'digest' unless defined?(Digest)
require 'commonthread/monkey_patches'

require 'commonthread/encrypter'

if defined?(ActionView)
	require 'commonthread/lipsum'
	ActionView::Base.send(:include, CommonThread::Lipsum::Helper)
end

if defined?(ActionController)
	require 'commonthread/filters'
	ActionController::Base.send(:include, CommonThread::Filters)
end

if defined?(Resque)
	require 'resque/mixin/async'
end
