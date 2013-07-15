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
        object = object_class_name.constantize.find(object_id)
        user = user_class_name.constantize.find(user_id) if user_class_name
        new(object, user, attrs)
      end

      def defer
        raise ArgumentError, "Implementation Required"
      end

      def work
        Audited.audit_class.as_user(@user) do
          @object.send(:write_audit_without_deferrable, @attrs)
        end
      end

    end
  end
end
