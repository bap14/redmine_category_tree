module RedmineCategoryTree
  module Patches
    module ApplicationHelperPatch
      def format_object(object, html=true, &block)
        if block_given?
          object = yield object
        end
        case object.class.name
        when 'IssueCategory'
          render_issue_category_with_tree_inline(object)
        else
          super
        end
      end
    end
  end
end