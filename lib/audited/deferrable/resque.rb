require "audited"
require "audited/deferrable/base"

module Audited
  module Deferrable
    class Resque < Base
      @queue = :audited

      def self.queue
        @queue
      end
      def self.queue=(value)
        @queue = value
      end

      def resque
        @resque ||= Resque.new
      end

      def defer
        ::Resque.enqueue(self.class, *arguments)
      end

      def self.perform(*args)
        from_arguments(*args).work
      end

    end
  end
end
