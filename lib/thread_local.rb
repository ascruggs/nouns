require "active_support/concern"

module ThreadLocal
  extend ActiveSupport::Concern

  module ClassMethods

    def thread_local
      Thread.current["Datastores::ThreadLocal/#{name}"] ||= {}
    end

    def thread_local_reload!
      thread_local.clear
    end

  end

  def thread_local
    self.class.thread_local
  end

end
