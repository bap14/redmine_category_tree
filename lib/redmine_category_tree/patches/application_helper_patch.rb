module RedmineCategoryTree
  module Patches
    module ApplicationHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          alias_method :format_object_without_category_tree, :format_object
          alias_method :format_object, :format_object_with_category_tree

        end
      end

      def format_object_with_category_tree(object, html=true, &block)
        if block_given?
          object = yield object
        end
        case object.class.name
        when 'IssueCategory'
          render_issue_category_with_tree_inline(object)
        else
         # super
	  format_object_without_category_tree(object, html, &block)
        end
      end
    end
  end
end
