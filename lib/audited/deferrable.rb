require "audited"

module Audited
  module Deferrable
    extend ActiveSupport::Concern

    included do
      Audited::Auditor::AuditedInstanceMethods.class_eval do
        alias_method :write_audit_without_deferrable, :write_audit

        def write_audit(attrs)
          if Audited.deferrable
            Audited.deferrable.new(self, Audited::Sweeper.instance.current_user, attrs).defer if auditing_enabled
          else
            write_audit_without_deferrable(attrs)
          end
        end
      end
    end

    module ClassMethods
      def defer_with
        @defer_with
      end

      def defer_with=(value)
        @defer_with = value
        deferrable
        @defer_with
      end

      def deferrable
        if @defer_with.nil?
          nil
        elsif @defer_with.is_a?(Class)
          @defer_with
        else
          begin
            require "audited/deferrable/#{@defer_with}"
            @defer_with = Audited::Deferrable.const_get(@defer_with.to_s.classify)
          rescue LoadError
            raise ArgumentError, "No handler exists for '#{@defer_with}'"
          end
        end
      end
    end

  end
end

Audited.send :include, Audited::Deferrable

