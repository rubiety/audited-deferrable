module Audited
  module Deferrable
    class Base

      def initialize(object, user, attrs)
        @object = object
        @user = user
        @attrs = attrs
      end

      def arguments
        [
          @object.class.name, 
          @object.id, 
          @user.try(:class).try(:name),
          @user.try(:id),
          @attrs
        ]
      end

      def self.from_arguments(object_class_name, object_id, user_class_name, user_id, attrs)
        object = object_class_name.constantize.find(object_id) rescue nil
        user = user_class_name.constantize.find(user_id) rescue nil if user_class_name
        new(object, user, attrs)
      end

      def defer
        raise ArgumentError, "Implementation Required"
      end

      def work
        if @object
          Audited.audit_class.as_user(@user) do
            @object.send(:write_audit_without_deferrable, @attrs)
          end
        else
          false
        end
      end

    end
  end
end
