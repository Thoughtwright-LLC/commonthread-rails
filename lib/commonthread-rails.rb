require 'commonthread/date_formats'
require 'commonthread/monkey_patches'

gem 'crypt'
require 'commonthread/encrypter'

if defined?(ActionView)
	require 'commonthread/lipsum'
	ActionView::Base.send(:include, CommonThread::Lipsum::Helper)
end

if defined?(ActionController)
	require 'commonthread/filters'
	ActionController::Base.send(:include, CommonThread::Filters)
end
