module Cms
  module Behaviors
    module Pagination
      def self.included(model_class)
        model_class.extend(ClassMethods)
        class << model_class
          define_method(:default_per_page) { 30 }
        end
      end
    end
  end
end