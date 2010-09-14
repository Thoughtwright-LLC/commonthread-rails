class Bj
  module Mixin
    # Module that provides easy queueing of jobs.
    # Transparently handles instance and class methods.
    #
    # If you consider this class:
    #
    #   class Repository < ActiveRecord::Base
    #     include Bj::Mixin::Async
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
        Bj.submit "CACHE_CLASSES=true ./script/runner '#{self.class.name}.perform(#{id}, #{method.inspect})'", :stdin => args.to_yaml, :is_restartable => false
      end
 
      module ClassMethods
        def async(method, *args)
          Bj.submit "CACHE_CLASSES=true ./script/runner '#{self.name}.perform(nil, #{method.inspect})'", :stdin => args.to_yaml, :is_restartable => false
        end
 
        # Performs a class method if id is nil or
        # an instance method if id has a value.
        def perform(id, method)
          args = YAML.load(STDIN)
 
          obj = id ? find(id) : self
          obj.send(method, *args)
        end
      end
    end
  end
end
