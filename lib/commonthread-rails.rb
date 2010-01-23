require 'commonthread/date_formats'
require 'commonthread/monkey_patches'
require 'commonthread/encrypter'

require 'commonthread/lipsum'
ActionView::Base.send(:include, CommonThread::Lipsum::Helper)

require 'commonthread/filters'
ActionController::Base.send(:include, CommonThread::Filters)
