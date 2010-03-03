module Resque
  module Mixin
    # Module that provides easy queueing of jobs.
    # Transparently handles instance and class methods.
    #
    # If you consider this class:
    #
    #   class Repository < ActiveRecord::Base
    #     include Resque::Mixin::Async
    #     @queue = :high_priority
    #
    #     def self.create_index
    #       # code
    #     end
    #
    #     def notify_watchers
    #       # code
    #     end
    #   end
    #
    # you can queue new jobs on both the class and an instance like this:
    #
    #   @repository.async(:notify_watchers)
    #   Repository.async(:create_index)
    #
    module Async
      def self.included(base)
        base.extend(ClassMethods)
      end
 
      def async(method, *args)
        Resque.enqueue(self.class, id, method, *args)
      end
 
      module ClassMethods
				def queue
					@queue || 'default'
				end

        def async(method, *args)
          Resque.enqueue(self, nil, method, *args)
        end
 
        # Performs a class method if id is nil or
        # an instance method if id has a value.
        def perform(*args)
          id = args.shift
          method = args.shift
 
          obj = id ? find(id) : self
          obj.send(method, *args)
        end
      end
    end
  end
end
