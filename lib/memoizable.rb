require 'active_support/concern'

module Memoizable
  extend ActiveSupport::Concern
  include ThreadLocal

  KEY_REGEX = /`([^']*)'/

  module ClassMethods

    def memoize(key = nil, &block)
      key = (key || caller[0][KEY_REGEX, 1]).to_s.gsub("?", "_question_mark")
      if thread_local.has_key?(key)
        thread_local[key]
      else
        thread_local[key] = block.call
      end
    end

  end

  def memoize(key = nil, &block)
    # It is super important to call Kernel.caller instead of just #caller,
    # because #caller is not defined for delegate classes; method missing
    # will be invoked which will call #memoize on the delegatee and then
    # #caller[0] will be 'method_missing'.
    key = "@" + (key || Kernel.caller[0][KEY_REGEX, 1]).to_s.gsub("?", "_question_mark")
    if instance_variable_defined?(key)
      instance_variable_get(key)
    else
      instance_variable_set(key, block.call)
    end
  end

end
